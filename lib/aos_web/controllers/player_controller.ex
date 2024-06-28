defmodule AosWeb.PlayerController do
  use AosWeb.Controller
  alias Aos.Service.RegisterPlayer

  def register(conn, body) do
    with {:ok, player} <- RegisterPlayer.call(body) do
      render(conn, "player.json", player: player)
    end
  end

  def me(conn, _body) do
    render(conn, "player.json", player: conn.assigns.player)
  end
end
