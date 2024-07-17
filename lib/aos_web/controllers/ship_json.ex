defmodule AosWeb.ShipJSON do
  import AosWeb.JsonViewHelpers
  alias AosWeb.PortJSON
  alias AosWeb.CompanyJSON

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
      speed: ship.speed
    }
    |> map_assoc_if_loaded(ship.port, :port, &PortJSON.port/1)
    |> map_assoc_if_loaded(ship.company, :company, &CompanyJSON.company/1)
  end

  def ships(ships) do
    for ship <- ships, do: ship(ship)
  end
end
