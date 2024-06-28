defmodule Aos.Service.ValidateAuthToken do
  alias Aos.Repo.AuthTokenRepo

  defp validate_expiry(token) do
    now = DateTime.now!("Etc/UTC") |> DateTime.truncate(:second)

    if DateTime.before?(now, token.expires_at) do
      :ok
    else
      {:error, :expired_token}
    end
  end

  def call(token) do
    with {:ok, token} <- AuthTokenRepo.find_token(token), :ok <- validate_expiry(token) do
      {:ok, token.player}
    end
  end
end
