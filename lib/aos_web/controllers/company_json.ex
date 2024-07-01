defmodule AosWeb.CompanyJSON do
  import AosWeb.JsonViewHelpers
  alias AosWeb.ShipJSON
  alias AosWeb.AgentJSON
  alias AosWeb.PlayerJSON

  def register(%{company: company}) do
    %{
      data: company(company)
    }
  end

  def list(%{page: page}) do
    %{
      data: for(company <- page.entries, do: public_company(company)),
      meta: page_meta(page)
    }
  end

  def public_company(company) do
    company(company)
    |> Map.drop([:treasury, :agents, :ships])
  end

  def company(company) do
    %{
      id: company.id,
      ticker: company.ticker,
      name: company.name,
      treasury: company.treasury
    }
    |> map_assoc_if_loaded(company.player, :player, &PlayerJSON.player/1)
    |> map_assoc_if_loaded(company.ships, :ships, &ShipJSON.ships/1)
    |> map_assoc_if_loaded(company.agents, :agents, &AgentJSON.agents/1)
  end
end
