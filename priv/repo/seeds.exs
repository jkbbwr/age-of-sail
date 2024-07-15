# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Aos.Repo.insert!(%Aos.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Aos.Repo.{
  PlayerRepo,
  PortRepo,
  RouteRepo,
  ShipyardRepo,
  ShipRepo,
  AuthTokenRepo,
  CompanyRepo,
  ItemRepo,
  TraderInventoryRepo,
  TraderPlanRepo,
  TraderRepo
}

### Players

{:ok, player} = PlayerRepo.create(%{name: "demo", email: "demo@demo.com", password: "password"})
# {:ok, _company} = CompanyRepo.create("test", "test company", 9999, player)

{:ok, _auth} =
  AuthTokenRepo.create(
    player,
    "auth",
    DateTime.now!("Etc/UTC") |> DateTime.add(30, :day) |> DateTime.truncate(:second)
  )

### Ports

{:ok, london} = PortRepo.create("London", "LOND")
{:ok, london_shipyard} = ShipyardRepo.create(london)

{:ok, demo_ship} = ShipRepo.create("Demo Ship 1", :sloop, 100, 100, :at_port, nil, london, nil)
{:ok, _shipyard_stock} = ShipyardRepo.create_stock(100, demo_ship, london_shipyard)

{:ok, port_of_spain} = PortRepo.create("Port of Spain", "PTOS")

{:ok, _london_to_port_of_spain} =
  RouteRepo.create(london, port_of_spain, "London -> Port of Spain", 1)

{:ok, _port_of_spain_to_london} =
  RouteRepo.create(port_of_spain, london, "Port of Spain -> London", 1)

### Items
{:ok, rum} =
  ItemRepo.create(
    "RUM",
    "Rum",
    "A popular alcoholic beverage distilled from sugarcane byproducts like molasses. It comes in various types, including white, golden, dark, and spiced."
  )

{:ok, london_trader} = TraderRepo.create("london trader", london)
{:ok, _london_rum_plan} = TraderPlanRepo.create(london_trader, rum, 1000, 0.25, 0.3, 10, 0.3)
{:ok, _london_rum_stock} = TraderInventoryRepo.create(london_trader, rum, 1, 100)
