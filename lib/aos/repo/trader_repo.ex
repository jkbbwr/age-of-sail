defmodule Aos.Repo.TraderRepo do
  use Aos, :repository
  alias Aos.Schema.Trader

  def create(name, port) do
    %Trader{}
    |> Trader.create(%{name: name, port: port})
    |> Repo.insert()
  end

  def find_by_id(id, preloads \\ []) do
    case(Repo.get(Trader, id) |> Repo.preload(preloads)) do
      nil -> {:error, :not_found}
      trader -> {:ok, trader}
    end
  end
end
