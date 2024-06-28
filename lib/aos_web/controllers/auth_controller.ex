defmodule AosWeb.AuthController do
  use AosWeb.Controller
  alias Aos.Service.LoginPlayer

  def login(conn, body) do
    case LoginPlayer.call(body) do
      {:ok, token} -> render(conn, "auth.json", token: token)
      {:error, :not_found} -> {:error, :invalid_password}
      err -> err
    end
  end
end
