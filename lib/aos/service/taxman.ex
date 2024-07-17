defmodule Aos.Service.Taxman do
  use Aos.Agent
  alias Aos.Repo.PortRepo

  def calculate_warehouse_tax(warehouse) do
  end

  def tax_warehouse(warehouse) do
  end

  @impl true
  def tick(_gametime, state) do
    {:ok, port} = PortRepo.find_by_id(state.port_id, warehouses: [:company])
    Enum.each(port.warehouses, &tax_warehouse/1)
    state
  end
end
