defmodule AosWeb.PlayerJSON do
  def register(%{player: player}) do
    %{
      data: player(player)
    }
  end

  def me(%{player: player}) do
    %{
      data: player(player)
    }
  end

  def player(player) do
    %{
      id: player.id,
      name: player.name,
      inserted_at: player.inserted_at,
      updated_at: player.updated_at
    }
  end
end
