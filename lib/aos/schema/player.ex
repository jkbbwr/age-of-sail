defmodule Aos.Schema.Player do
  use Aos.Schema

  schema "player" do
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :password_hash, :string

    # has_one :company, Aos.Schema.Company
    has_many :auth_tokens, Aos.Schema.AuthToken
    timestamps()
  end

  def changeset(player, attrs \\ %{}) do
    player
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> unique_constraint([:email])
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
