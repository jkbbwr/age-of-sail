defmodule Aos.Repo.ShipRepo do
  use Aos, :repository
  alias Aos.Schema.Ship

  def create(name, type, cargo_space, speed, state, port, company) do
    %Ship{}
    |> Ship.create_changeset(%{
      name: name,
      type: type,
      cargo_space: cargo_space,
      speed: speed,
      port: port,
      company: company,
      state: state
    })
    |> Repo.insert()
  end

  def update_company(ship, company) do
    ship
    |> Ship.update_company_changeset(%{company: company})
    |> Repo.update()
  end
end
