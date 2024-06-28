defmodule AosWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias Aos.Service.ValidateAuthToken

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> get_token()
    |> ValidateAuthToken.call()
    |> case do
      {:ok, player} ->
        assign(conn, :player, player)

      {:error, :expired_token} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(AosWeb.ErrorJSON)
        |> render(:expired_token)
        |> halt()

      _ ->
        conn
        |> put_status(:unauthorized)
        |> put_view(AosWeb.ErrorJSON)
        |> render(:invalid_auth)
        |> halt()
    end
  end

  defp get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> token
      _ -> ""
    end
  end
end
