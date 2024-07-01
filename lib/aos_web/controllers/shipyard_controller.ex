defmodule AosWeb.ShipyardController do
  use AosWeb.Controller
  alias Aos.Repo.ShipyardRepo

  def get(conn, %{shipyard_id: shipyard_id}) do
    with {:ok, shipyard} <- ShipyardRepo.find_by_id(shipyard_id) do
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
end
