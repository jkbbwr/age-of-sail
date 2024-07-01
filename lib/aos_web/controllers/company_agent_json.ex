defmodule AosWeb.CompanyAgentJSON do
  import AosWeb.JsonViewHelpers

  alias AosWeb.PortJSON
  alias AosWeb.CompanyJSON

  def hire(%{agent: agent}) do
    %{
      data: agent(agent)
    }
  end

  def agent(agent) do
    %{
      id: agent.id,
      inserted_at: agent.inserted_at,
      updated_at: agent.updated_at
    }
    |> map_assoc_if_loaded(agent.port, :port, &PortJSON.port/1)
    |> map_assoc_if_loaded(agent.company, :company, &CompanyJSON.company/1)
  end
end
