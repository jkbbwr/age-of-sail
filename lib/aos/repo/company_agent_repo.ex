defmodule Aos.Repo.CompanyAgentRepo do
  use Aos, :repository
  alias Aos.Schema.CompanyAgent

  def create(company, port) do
    %CompanyAgent{}
    |> CompanyAgent.changeset(%{company: company, port: port})
    |> Repo.insert()
  end
end
