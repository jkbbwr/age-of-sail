defmodule AosWeb.CompanyAgentController do
  use AosWeb.Controller
  alias Aos.Service.HireAgent

  def hire(conn, body) do
    with {:ok, agent} <- HireAgent.call(body) do
      render(conn, "agent.json", agent: agent)
    end
  end
end
