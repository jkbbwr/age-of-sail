defmodule Aos.Repo.TraderInventoryRepo do
  use Aos, :repository
  alias Aos.Schema.TraderInventory

  def create(trader, item, quantity, cost) do
    %TraderInventory{}
    |> TraderInventory.create(%{trader: trader, item: item, quantity: quantity, cost: cost})
    |> Repo.insert()
  end

  def find_by_trader_id_and_item_id(trader_id, item_id) do
    query =
      from inventory in TraderInventory,
        where: inventory.trader_id == ^trader_id and inventory.item_id == ^item_id,
        preload: [:item, :trader],
        select: inventory

    case Repo.one(query) do
      nil -> {:error, :not_found}
      inventory -> {:ok, inventory}
    end
  end
end
