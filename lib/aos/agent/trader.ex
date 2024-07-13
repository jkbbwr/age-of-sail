defmodule Aos.Agent.Trader do
  use Aos.Agent
  alias Aos.Repo.TraderRepo

  defp normalize(value, max_value) when max_value != 0 do
    value / max_value
  end

  defp produce_stock(
         current_amount,
         max_amount,
         peak_production,
         mean \\ 0.5,
         std_dev \\ 0.1,
         fluctuation \\ 0.05
       ) do
    x = normalize(current_amount, max_amount)
    production = peak_production * :math.exp(-((x - mean) ** 2) / (2 * std_dev ** 2))
    random_factor = 1 + (:rand.uniform() - 0.5) * 2 * fluctuation
    production * random_factor
  end

  defp adjust_price(
         current_amount,
         max_amount,
         base_price,
         sensitivity \\ 0.5,
         fluctuation \\ 0.05
       ) do
    x = normalize(current_amount, max_amount)
    new_price = base_price * (1 + sensitivity * (1 - x))
    random_factor = 1 + (:rand.uniform() - 0.5) * 2 * fluctuation
    new_price * random_factor
  end

  defp adjust(plan) do
  end

  @impl true
  def tick(_gametime, state) do
    {:ok, trader} = TraderRepo.find_by_id(state.trader_id, plans: [:item, :trader])
    Enum.each(trader.plans, &adjust/1)

    {:noreply, state}
  end
end
