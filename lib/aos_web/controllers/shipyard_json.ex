defmodule AosWeb.ShipyardJSON do
  alias AosWeb.ShipJSON
  alias AosWeb.PortJSON
  import AosWeb.JsonViewHelpers

  def get(%{shipyard: shipyard}) do
    %{
      data: shipyard(shipyard)
    }
  end

  def all(%{page: page}) do
    %{
      data: for(yard <- page.entries, do: shipyard(yard)),
      meta: page_meta(page)
    }
  end

  def buy(%{ship: ship}) do
    %{
      data: ShipJSON.ship(ship)
    }
  end

  def shipyard(shipyard) do
    %{
      id: shipyard.id
    }
    |> map_assoc_if_loaded(shipyard.port, :port, &PortJSON.port/1)
    |> map_assoc_if_loaded(shipyard.ships, :ships, &stocks/1)
  end

  def stock(stock) do
    %{
      id: stock.id,
      cost: stock.cost
    }
    |> map_assoc_if_loaded(stock.ship, :ship, &ShipJSON.ship/1)
  end

  def stocks(stocks) do
    for stock <- stocks, do: stock(stock)
  end
end
