defmodule AosWeb.ShipyardController do
  use AosWeb.Controller
  alias Aos.Repo.ShipyardRepo
  alias Aos.Service.BuyShip

  def get(conn, %{"shipyard_id" => shipyard_id}) do
    with {:ok, shipyard} <- ShipyardRepo.find_by_id(shipyard_id, preload: [ships: :ship]) do
      render(conn, :get, shipyard: shipyard)
    end
  end

  def all(conn, attrs) do
    with {:ok, page} <-
           ShipyardRepo.all(
             page: attrs[:page],
             page_size: attrs[:page_size],
             preload: [:port, ships: :ship]
           ) do
      render(conn, :all, page: page)
    end
  end

  def buy(conn, params) do
    with {:ok, ship} <- BuyShip.call(conn.assigns.player, params) do
      conn
      |> put_status(:accepted)
      |> render(:buy, ship: ship)
    end
  end
end
