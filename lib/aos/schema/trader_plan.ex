defmodule Aos.Schema.TraderPlan do
  use Aos.Schema

  schema "trader_plan" do
    belongs_to :trader, Aos.Schema.Trader
    belongs_to :item, Aos.Schema.Item

    field :desire, Ecto.Enum, values: [:buy, :sell], default: :sell

    field :desired_stock, :integer
    field :price_elasticity, :float
    field :price_volatility, :float

    field :replenishment_rate, :integer
    field :stock_volatility, :float
    timestamps()
  end

  def create(trader_plan, attrs) do
    trader_plan
    |> cast(attrs, [
      :desired_stock,
      :price_elasticity,
      :price_volatility,
      :replenishment_rate,
      :stock_volatility
    ])
    |> put_assoc(:trader, attrs.trader)
    |> put_assoc(:item, attrs.item)
    |> validate_required([
      :desired_stock,
      :price_elasticity,
      :price_volatility,
      :replenishment_rate,
      :stock_volatility
    ])
  end
end
