defmodule AosWeb.ShipyardJSON do
  alias AosWeb.ShipJSON
  alias AosWeb.PortJSON

  def render("shipyard.json", attrs) do
    %{
      data: shipyard_with_stock(attrs)
    }
  end

  def render("shipyards.json", %{page: page}) do
    %{
      data: for(yard <- page.entries, do: shipyard(yard)),
      meta: %{
        page_number: page.page_number,
        page_size: page.page_size,
        total_entries: page.total_entries,
        total_pages: page.total_pages
      }
    }
  end

  def shipyard_with_stock(shipyard) do
  end

  def shipyard(shipyard) do
    %{
      id: shipyard.id,
      port: PortJSON.port(shipyard.port)
    }
  end
end
