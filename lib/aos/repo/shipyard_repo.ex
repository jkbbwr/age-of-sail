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

  def all(opts \\ []) do
    page = Keyword.get(opts, :page, 1)
    page_size = Keyword.get(opts, :page_size, 10)
    preload = Keyword.get(opts, :preload, [])

    all =
      from yard in Shipyard,
        preload: ^preload,
        select: yard

    {:ok, all |> Repo.paginate(%{page: page, page_size: page_size})}
  end
end
