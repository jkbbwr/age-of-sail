defmodule Aos.Schema.TraderPlan do
  use Aos.Schema

  schema "trader_plan" do
    belongs_to :trader, Aos.Schema.Trader
    belongs_to :item, Aos.Schema.Item
    field :peak, :integer
    field :max, :integer
    field :fluctuation, :float
    field :mean, :float
    field :std_dev, :float
    field :sensitivity, :float
    timestamps()
  end

  def create(trader_plan, attrs) do
    trader_plan
    |> cast(attrs, [:peak, :max, :fluctuation, :mean, :std_dev, :sensitivity])
    |> put_assoc(:trader, attrs.trader)
    |> put_assoc(:item, attrs.item)
    |> validate_required([:peak, :max, :fluctuation, :mean, :std_dev, :sensitivity])
    |> validate_number(:peak, greater_than: 0)
    |> validate_number(:max, greater_than: 0)
    |> validate_number(:sensitivity, greater_than: 0)
    |> validate_number(:mean, greater_than: 0.0, less_than: 1.0)
    |> validate_number(:std_dev, greater_than: 0.0, less_than: 1.0)
    |> validate_number(:fluctuation, greater_than: 0.0, less_than: 1.0)
  end
end
