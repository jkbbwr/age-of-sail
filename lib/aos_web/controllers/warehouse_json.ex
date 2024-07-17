defmodule AosWeb.WarehouseJSON do
  import AosWeb.JsonViewHelpers
  alias AosWeb.PortJSON

  def buy(%{warehouse: warehouse}) do
    %{
      data: warehouse(warehouse)
    }
  end

  def warehouse(warehouse) do
    %{
      id: warehouse.id,
      capacity: warehouse.capacity
    }
    |> map_assoc_if_loaded(warehouse.port, :port, &PortJSON.port/1)
  end
end
