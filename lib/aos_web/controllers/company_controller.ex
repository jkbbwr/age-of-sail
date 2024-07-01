defmodule AosWeb.CompanyController do
  use AosWeb.Controller
  alias Aos.Service.RegisterCompany
  alias Aos.Repo.CompanyRepo

  def register(conn, body) do
    with {:ok, company} <- RegisterCompany.call(conn.assigns.player, body) do
      conn
      |> put_status(:created)
      |> render(:register, company: company)
    end
  end

  def list(conn, params) do
    render(conn, :list, page: CompanyRepo.all(params))
  end
end
