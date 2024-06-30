defmodule Aos.Service.HireAgent do
  alias Aos.Repo.CompanyRepo
  alias Aos.Repo.CompanyAgentRepo
  alias Aos.Repo.PortRepo
  alias Aos.Schema.CompanyAgent

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :port_id, Ecto.UUID
    field :company_id, Ecto.UUID
  end

  defp validate(payload) do
    changeset =
      %__MODULE__{}
      |> cast(payload, [:port_id, :company_id])
      |> validate_required([:port_id, :company_id])

    if changeset.valid? do
      {:ok, changeset.changes}
    else
      {:error, changeset}
    end
  end

  defp verify_player_owns_company(player, company) do
    if company.player_id == player.id do
      true
    else
      {:error, :company_not_owned_by_player}
    end
  end

  @spec call(Aos.Schema.Player.t(), %{port_id: String.t(), company_id: String.t()}) ::
          {:ok, CompanyAgent.t()} | {:error, any()}
  def call(player, payload) do
    with {:ok, data} <- validate(payload),
         {:ok, company} <- CompanyRepo.find_by_id(data.company_id),
         true <- verify_player_owns_company(player, company),
         {:ok, port} <- PortRepo.find_by_id(data.port_id) do
      CompanyAgentRepo.create(company, port)
    end
  end
end
