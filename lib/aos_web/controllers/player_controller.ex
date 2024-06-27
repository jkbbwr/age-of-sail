defmodule AosWeb.PlayerController do
  use AosWeb, :controller
  alias Aos.Service.RegisterPlayer
  action_fallback AosWeb.FallbackController

  def register(conn, body) do
    with {:ok, player} <- RegisterPlayer.call(body) do
      render(conn, "player.json", player: player)
    end
  end
end
