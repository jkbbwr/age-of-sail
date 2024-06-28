defmodule Aos.Repo.AuthTokenRepo do
  use Aos, :repository
  alias Aos.Schema.AuthToken

  def create(player, token, expires_at) do
    player
    |> Ecto.build_assoc(:auth_tokens,
      token: token,
      expires_at: expires_at
    )
    |> Repo.insert()
  end

  def find_token(token) do
    token =
      AuthToken
      |> Repo.get_by(token: token)
      |> Repo.preload(:player)

    case token do
      nil -> {:error, :not_found}
      token -> {:ok, token}
    end
  end
end
