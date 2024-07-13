defmodule Aos.Schema.TraderInventory do
  use Aos.Schema

  schema "trader_inventory" do
    belongs_to :trader, Aos.Schema.Trader
    belongs_to :item, Aos.Schema.Item
    field :quantity, :integer
    field :cost, :integer
    timestamps()
  end

  def create(trader_inventory, attrs) do
    trader_inventory
    |> cast(attrs, [:cost, :quantity])
    |> put_assoc(:trader, attrs.trader)
    |> put_assoc(:item, attrs.item)
    |> unique_constraint([:trader, :item])
  end
end