defmodule Aos.Schema.TraderInventory do
  use Aos.Schema

  schema "trader_inventory" do
    belongs_to :trader, Aos.Schema.Trader
    belongs_to :item, Aos.Schema.Item
    field :stock, :integer
    field :cost, :integer
    field :desire, Ecto.Enum, values: [:buy, :sell], default: :sell
    timestamps()
  end

  def create(trader_inventory, attrs) do
    trader_inventory
    |> cast(attrs, [:cost, :stock])
    |> put_assoc(:trader, attrs.trader)
    |> put_assoc(:item, attrs.item)
    |> unique_constraint([:trader, :item])
    |> validate_required([:cost, :stock])
  end

  def update(trader_inventory, attrs) do
    trader_inventory
    |> cast(attrs, [:cost, :stock])
    |> validate_required([:cost, :stock])
  end
end
