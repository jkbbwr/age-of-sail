defmodule Aos.Schema.Shipyard do
  use Aos.Schema

  schema "shipyard" do
    belongs_to :port, Aos.Schema.Port
    has_many :ships, Aos.Schema.ShipyardStock
    timestamps()
  end

  def changeset(ship, attrs \\ %{}) do
    ship
    |> cast(attrs, [])
    |> put_assoc(:port, attrs.port)
    |> validate_required([:port])
    |> unique_constraint([:port])
  end
end
