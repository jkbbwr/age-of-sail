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

  def find_stock_by_ship_id(yard, ship_id, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])

    query =
      from stock in ShipyardStock,
        join: shipyard in assoc(stock, :shipyard),
        on: shipyard.id == ^yard.id,
        join: ship in assoc(stock, :ship),
        on: ship.id == ^ship_id,
        preload: ^preload,
        select: stock

    case Repo.one(query) do
      nil -> {:error, :not_found}
      stock -> {:ok, stock}
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

  def transfer_ship_to_company(_stock, _company) do
    raise "Not implemented yet"
  end
end
