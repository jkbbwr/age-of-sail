defmodule Aos.Repo.ShipyardRepo do
  use Aos, :repository
  alias Aos.Schema.Shipyard
  alias Aos.Schema.ShipyardStock

  def create(port) do
    %Shipyard{}
    |> Shipyard.changeset(%{port: port})
    |> Repo.insert()
  end

  def create_stock(cost, ship, shipyard) do
    %ShipyardStock{}
    |> ShipyardStock.changeset(%{cost: cost, ship: ship, shipyard: shipyard})
    |> Repo.insert()
  end

  def find_by_id(id, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])

    case Repo.get(Shipyard, id) |> Repo.preload(preload) do
      nil -> {:error, :not_found}
      shipyard -> {:ok, shipyard}
    end
  end

  def all(params \\ %{}) do
    query =
      from yard in Shipyard,
        join: p in assoc(yard, :port),
        join: s in assoc(yard, :ships),
        join: e in assoc(s, :ship),
        preload: [ships: {s, ship: e}, port: p],
        select: yard

    {:ok, Repo.paginate(query, params)}
  end
end
