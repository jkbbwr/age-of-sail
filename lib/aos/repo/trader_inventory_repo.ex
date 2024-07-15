defmodule Aos.Repo.TraderInventoryRepo do
  use Aos, :repository
  alias Aos.Schema.TraderInventory

  def create(trader, item, stock, cost) do
    %TraderInventory{}
    |> TraderInventory.create(%{trader: trader, item: item, stock: stock, cost: cost})
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

  def update_cost_and_stock(inventory, cost, stock) do
    inventory
    |> TraderInventory.update(%{
      cost: cost,
      stock: stock
    })
    |> Repo.update()
  end
end
