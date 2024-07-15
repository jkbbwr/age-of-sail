defmodule Aos.Repo.TraderPlanRepo do
  use Aos, :repository
  alias Aos.Schema.TraderPlan

  def create(
        trader,
        item,
        desired_stock,
        price_elasticity,
        price_volatility,
        replenishment_rate,
        stock_volatility
      ) do
    %TraderPlan{}
    |> TraderPlan.create(%{
      trader: trader,
      item: item,
      desired_stock: desired_stock,
      price_elasticity: price_elasticity,
      price_volatility: price_volatility,
      replenishment_rate: replenishment_rate,
      stock_volatility: stock_volatility
    })
    |> Repo.insert()
  end
end
