defmodule AosWeb.ShipJSON do
  def render("ship.json", %{ship: ship}) do
    %{
      data: ship(ship)
    }
  end

  def ship(ship) do
    %{
      id: ship.id,
      name: ship.name,
      type: ship.type,
      cargo_space: ship.cargo_space,
      speed: ship.speed,
      port: ship.port,
      owner: ship.owner,
      arriving_at: ship.arriving_at
    }
  end

  def ships(ships) do
    for ship <- ships, do: ship(ship)
  end
end
