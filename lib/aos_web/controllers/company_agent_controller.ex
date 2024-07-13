defmodule AosWeb.CompanyAgentController do
  use AosWeb.Controller
  alias Aos.Service.HireAgent

  def hire(conn, body) do
    with {:ok, agent} <- HireAgent.call(conn.assigns.player, body) do
      conn
      |> put_status(:created)
      |> render(:hire, agent: agent)
    else
      {:error, :company_not_owned_by_player} -> {:error, :forbidden}
      e -> e
    end
  end
end
