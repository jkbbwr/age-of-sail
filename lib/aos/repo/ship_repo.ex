defmodule Aos.Repo.ShipRepo do
  use Aos, :repository
  alias Aos.Schema.Ship

  def create(name, type, cargo_space, speed, state, arriving_at, port, company) do
    %Ship{}
    |> Ship.changeset(%{
      name: name,
      type: type,
      cargo_space: cargo_space,
      speed: speed,
      state: state,
      arriving_at: arriving_at,
      port: port,
      company: company
    })
    |> Repo.insert()
  end
end
