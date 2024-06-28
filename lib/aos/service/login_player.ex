defmodule Aos.Service.LoginPlayer do
  alias Aos.Repo.PlayerRepo
  alias Aos.Repo.AuthTokenRepo

  @one_day_in_seconds 86_400
  @token_length 64

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :email, :string
    field :password, :string
  end

  defp validate(payload) do
    changeset =
      %__MODULE__{}
      |> cast(payload, [:email, :password])
      |> validate_format(:email, ~r/@/)
      |> validate_required([:email, :password])

    if changeset.valid? do
      {:ok, changeset.changes}
    else
      {:error, changeset}
    end
  end

  defp generate_token() do
    :crypto.strong_rand_bytes(@token_length)
    |> Base.encode64(padding: false)
    |> binary_part(0, @token_length)
  end

  defp verify_password(password, hash) do
    if Argon2.verify_pass(password, hash) do
      :ok
    else
      {:error, :invalid_password}
    end
  end

  def call(payload) do
    with {:ok, data} <- validate(payload),
         {:ok, player} <- PlayerRepo.find_by_email(data.email),
         :ok <- verify_password(data.password, player.password_hash) do
      token = generate_token()

      expires_at =
        DateTime.now!("Etc/UTC")
        |> DateTime.truncate(:second)
        |> DateTime.add(@one_day_in_seconds, :second)

      AuthTokenRepo.create(player, token, expires_at)
    end
  end
end
