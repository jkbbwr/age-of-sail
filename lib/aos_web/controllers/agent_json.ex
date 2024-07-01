defmodule AosWeb.AgentJSON do
  import AosWeb.JsonViewHelpers

  alias AosWeb.PortJSON
  alias AosWeb.CompanyJSON

  def agent(agent) do
    %{
      id: agent.id,
      port_id: agent.port_id,
      company_id: agent.company_id
    }
    |> map_assoc_if_loaded(agent.port, :port, &PortJSON.port/1)
    |> map_assoc_if_loaded(agent.company, :company, &CompanyJSON.company/1)
  end

  def agents(agents) do
    for agent <- agents, do: agent(agent)
  end
end
