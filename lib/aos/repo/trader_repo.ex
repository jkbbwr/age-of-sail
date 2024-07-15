defmodule Aos.Repo.TraderRepo do
  use Aos, :repository
  alias Aos.Schema.Trader

  def create(name, port) do
    %Trader{}
    |> Trader.create(%{name: name, port: port})
    |> Repo.insert()
  end

  def all() do
    Repo.all(Trader)
  end

  def find_by_id(id, preloads \\ []) do
    wrap_not_found(Repo.get(Trader, id) |> Repo.preload(preloads))
  end
end
