defmodule AosWeb.WarehouseController do
  use AosWeb.Controller

  alias Aos.Service.BuyWarehouseCapacity

  def buy(conn, attrs) do
    with {:ok, warehouse} <- BuyWarehouseCapacity.call(conn.assigns.player, attrs) do
      conn
      |> put_status(:created)
      |> render(:buy, warehouse: warehouse)
    end
  end
end
