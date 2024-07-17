defmodule Aos.TraderSupervisor do
  use Supervisor
  alias Aos.Repo.TraderRepo

  def start_link(start_numbers) do
    Supervisor.start_link(__MODULE__, start_numbers, name: __MODULE__)
  end

  @impl true
  def init(_) do
    children = for trader <- TraderRepo.all(), do: {Aos.Service.Trader, %{trader_id: trader.id}}
    Supervisor.init(children, strategy: :one_for_one)
  end
end
