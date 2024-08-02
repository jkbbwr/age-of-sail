defmodule Aos.Service.BuyWarehouseCapacity do
  use Aos.Service

  alias Aos.Repo.CompanyAgentRepo
  alias Aos.Repo.WarehouseRepo

  embedded_schema do
    field :agent_id, Ecto.UUID
    field :capacity, :integer
  end

  changeset payload do
    %__MODULE__{}
    |> cast(payload, [:agent_id, :capacity])
    |> validate_required([:agent_id, :capacity])
    |> validate_number(:capacity, greater_than: 0, less_than_or_equal_to: 10000)
  end

  def authorize(:call, %{id: player_id}, %{company: company}) when company.player_id != player_id,
    do: {:error, Aos.Error.AgentNotEmployedByCompany.new(%{})}

  def authorize(:call, _, _), do: true

  def call(player, payload) do
    with {:ok, args} <- validate(payload),
         {:ok, agent} <- CompanyAgentRepo.find_by_id(args.agent_id, preload: [:company, :port]),
         :ok <- Bodyguard.permit(__MODULE__, :call, player, company: agent.company) do
      WarehouseRepo.create(agent.port, agent.company, args.capacity)
    end
  end
end
