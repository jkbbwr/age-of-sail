defmodule AosWeb.PlayerJSON do
  def render("player.json", %{player: player}) do
    %{
      data: %{
        id: player.id,
        email: player.email,
        inserted_at: player.inserted_at,
        updated_at: player.updated_at
      }
    }
  end
end
