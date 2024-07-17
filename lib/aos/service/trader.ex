defmodule Aos.Service.Trader do
  use Aos.Agent
  alias Aos.Repo
  alias Aos.Repo.TraderRepo
  alias Aos.Repo.TraderInventoryRepo

  @doc """
       Calculates a new price for an item based on current price, desired stock, current stock,
       elasticity factor, and a volatility factor.

       ## Parameters
       - `current_price` (float): The current price of the item.
       - `desired_stock` (integer): The desired stock level.
       - `current_stock` (integer): The current stock level.
       - `elasticity_factor` (float): A factor controlling how sensitive the price is to changes in stock levels.
         Typically ranges from 0.0 (no sensitivity) to 1.0 (high sensitivity).
       - `volatility_factor` (float): A factor controlling the degree of randomness in price adjustments.
         Ranges from 0.0 (no randomness) to 1.0 (very random).

       ## Returns
       - `new_price` (float): The newly calculated price for the item.
       """ && false
  defp calculate_new_cost(
         current_price,
         desired_stock,
         current_stock,
         elasticity_factor,
         volatility_factor
       ) do
    demand_factor = (desired_stock - current_stock) / desired_stock
    base_price_change = demand_factor / current_stock * elasticity_factor
    random_volatility = (:rand.uniform() * 2 - 1) * volatility_factor
    volatility_adjustment = base_price_change * random_volatility
    new_price = current_price * (1 + base_price_change + volatility_adjustment)
    floor(new_price)
  end

  @doc """
       Calculates the new stock level based on the current stock level, desired stock level, base replenishment rate, and volatility factor.

       ## Parameters
       - `current_stock` (integer): The current stock level.
       - `desired_stock` (integer): The desired stock level.
       - `base_replenishment_rate` (integer): The base rate at which stock is replenished.
       - `volatility_factor` (float): A factor controlling the degree of randomness in replenishment.
         Ranges from 0.0 (no randomness) to 1.0 (very random).

       ## Returns
       - `new_stock` (integer): The newly calculated stock level.
       """ && false
  defp calculate_new_stock(
         current_stock,
         desired_stock,
         base_replenishment_rate,
         volatility_factor
       ) do
    # Calculate the replenishment rate using a logistic function with a cap
    stock_ratio = current_stock / desired_stock

    replenishment_rate =
      base_replenishment_rate * (1 - stock_ratio) / (1 + :math.exp(stock_ratio - 1))

    # Cap the replenishment rate to ensure it trends to zero
    replenishment_rate = max(replenishment_rate, 0)

    # Add random volatility
    random_volatility = (:rand.uniform() * 2 - 1) * volatility_factor
    replenishment_rate = replenishment_rate * (1 + random_volatility)

    new_stock = current_stock + replenishment_rate
    floor(new_stock)
  end

  defp adjust(plan) do
    Repo.transaction(fn ->
      {:ok, inventory} =
        TraderInventoryRepo.find_by_trader_id_and_item_id(plan.trader.id, plan.item.id)

      new_cost =
        calculate_new_cost(
          inventory.cost,
          plan.desired_stock,
          inventory.stock,
          plan.price_elasticity,
          plan.price_volatility
        )

      new_stock =
        calculate_new_stock(
          inventory.stock,
          plan.desired_stock,
          plan.replenishment_rate,
          plan.stock_volatility
        )

      Logger.debug(
        "Trader (#{plan.trader.name}) - #{plan.item.name} - Updating cost from #{inventory.cost} to #{new_cost} and stock is being set to #{new_stock} (from #{inventory.stock})"
      )

      TraderInventoryRepo.update_cost_and_stock(inventory, new_cost, new_stock)
    end)
  end

  @impl true
  def tick(_gametime, state) do
    {:ok, trader} = TraderRepo.find_by_id(state.trader_id, plans: [:item, :trader])
    Logger.debug("Trader (#{trader.name}) - Running stock / price updates")

    Enum.each(trader.plans, &adjust/1)

    state
  end
end
