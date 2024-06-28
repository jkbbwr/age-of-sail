defmodule Aos.Repo.ShipRepo do
  use Aos, :repository
  alias Aos.Schema.Ship

  """

  field :type, Ecto.Enum, values: [:sloop, :brig, :frigate, :galleon, :ship_of_the_line]
  field :cargo_space, :integer
  field :state, Ecto.Enum, values: [:in_port, :at_sea, :destroyed]
  """

  def create(name, type, cargo_space, state, arriving_at, port, owner) do
    %Ship{}
    |> Ship.changeset(%{
      name: name,
      type: type,
      cargo_space: cargo_space,
      state: state,
      arriving_at: arriving_at,
      port: port,
      owner: owner
    })
    |> Repo.insert()
  end
end
