defmodule Aos.Repo.CompanyAgentRepo do
  use Aos, :repository
  alias Aos.Schema.CompanyAgent

  def create(company, port) do
    agent =
      %CompanyAgent{}
      |> CompanyAgent.changeset(%{company: company, port: port})
      |> Repo.insert()

    case agent do
      {:ok, agent} -> {:ok, Repo.preload(agent, [:company, :port])}
      error -> error
    end
  end

  def find_by_id(id, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])
    wrap_not_found(Repo.get(CompanyAgent, id) |> Repo.preload(preload))
  end
end
