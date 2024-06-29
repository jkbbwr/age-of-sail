defmodule AosWeb.CompanyAgentJSON do
  def render("agent.json", %{agent: agent}) do
    %{
      id: agent.id,
      company_id: agent.company.id,
      port_id: agent.port.id,
      inserted_at: agent.inserted_at,
      updated_at: agent.updated_at
    }
  end
end
