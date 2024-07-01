defmodule AosWeb.PlayerController do
  use AosWeb.Controller
  alias Aos.Service.RegisterPlayer

  def register(conn, body) do
    with {:ok, player} <- RegisterPlayer.call(body) do
      conn
      |> put_status(:created)
      |> render("register.json", player: player)
    end
  end

  def me(conn, _body) do
    render(conn, "me.json", player: conn.assigns.player)
  end
end
