defmodule Aos.TaxmanSupervisor do
  use Supervisor
  alias Aos.Repo.PortRepo

  def start_link(start_numbers) do
    Supervisor.start_link(__MODULE__, start_numbers, name: __MODULE__)
  end

  @impl true
  def init(_) do
    children = for id <- PortRepo.all_ids(), do: {Aos.Service.Taxman, %{port_id: id}}
    Supervisor.init(children, strategy: :one_for_one)
  end
end
