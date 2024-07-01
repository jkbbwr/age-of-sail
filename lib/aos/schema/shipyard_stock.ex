defmodule Aos.Schema.ShipyardStock do
  use Aos.Schema

  schema "shipyard_stock" do
    belongs_to :shipyard, Aos.Schema.Shipyard
    belongs_to :ship, Aos.Schema.Ship
    field :cost, :integer
    timestamps()
  end

  def changeset(shipyard_stock, attrs \\ %{}) do
    shipyard_stock
    |> cast(attrs, [:cost])
    |> put_assoc(:ship, attrs.ship)
    |> put_assoc(:shipyard, attrs.shipyard)
    |> validate_required([:cost, :ship, :shipyard])
  end
end
