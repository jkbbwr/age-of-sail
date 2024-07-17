defmodule Aos.Repo.WarehouseRepo do
  use Aos, :repository
  alias Aos.Schema.Warehouse

  def create(port, company, capacity) do
    %Warehouse{}
    |> Warehouse.create(%{port: port, company: company, capacity: capacity})
    |> Repo.insert()
  end

  def all() do
    Repo.all(Trader)
  end

  def find_by_id(id, preloads \\ []) do
    wrap_not_found(Repo.get(Trader, id) |> Repo.preload(preloads))
  end

  def upsert_capacity(id, port, company, capacity) do
    %Warehouse{}
    |> Warehouse.create(%{id: id, port: port, company: company, capacity: capacity})
    |> Repo.insert(
      on_conflict: [set: [capacity: capacity]],
      conflict_target: [:port, :company]
    )
  end
end
