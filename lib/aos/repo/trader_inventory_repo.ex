defmodule Aos.Repo.TraderInventoryRepo do
  use Aos, :repository
  alias Aos.Schema.TraderPlan

  def create(
        trader,
        item,
        peak,
        max,
        fluctuation \\ 0.05,
        mean \\ 0.5,
        std_dev \\ 0.1,
        sensitivity \\ 0.5
      )

  def create(trader, item, peak, max, fluctuation, mean, std_dev, sensitivity) do
    %TraderPlan{}
    |> TraderPlan.create(%{
      trader: trader,
      item: item,
      peak: peak,
      max: max,
      fluctuation: fluctuation,
      mean: mean,
      std_dev: std_dev,
      sensitivity: sensitivity
    })
    |> Repo.insert()
  end
end
