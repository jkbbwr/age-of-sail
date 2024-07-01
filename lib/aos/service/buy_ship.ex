defmodule Aos.Service.BuyShip do
  use Ecto.Schema
  import Ecto.Changeset
  alias Aos.Repo.PortRepo
  alias Aos.Repo.CompanyAgentRepo
  alias Aos.Repo.CompanyRepo
  alias Aos.Repo.ShipyardRepo

  embedded_schema do
    field :agent_id, Ecto.UUID
    field :company_id, Ecto.UUID
    field :shipyard_id, Ecto.UUID
    field :ship_id, Ecto.UUID
  end

  def validate(payload) do
    changeset =
      %__MODULE__{}
      |> cast(payload, [:port_id, :company_id, :shipyard_id, :ship_id])
      |> validate_required([:port_id, :company_id, :shipyard_id, :ship_id])

    if changeset.valid? do
      {:ok, changeset.changes}
    else
      {:error, changeset}
    end
  end

  def agent_works_for_company?(agent, company) do
    if agent.company.id == company.id do
      :ok
    else
      {:error, :unauthorized}
    end
  end

  def player_owns_company?(player, company) do
    if player.id == company.player.id do
      :ok
    else
      {:error, :unauthorized}
    end
  end

  def company_can_afford_purchase?(company, stock) do
    if company.treasury <= stock.cost do
      :ok
    else
      {:error, :not_enough_treasury}
    end
  end

  def call(player, payload) do
    Aos.Repo.transaction(fn ->
      with {:ok, data} <- validate(payload),
           {:ok, company} <- CompanyRepo.find_by_id(data.company_id, preload: [:player]),
           :ok <- player_owns_company?(player, company),
           {:ok, agent} <- CompanyAgentRepo.find_by_id(data.agent_id, preload: [:company]),
           :ok <- agent_works_for_company?(agent, company),
           {:ok, yard} <- ShipyardRepo.find_by_id(data.shipyard_id),
           {:ok, stock} <-
             ShipyardRepo.find_stock_by_ship_id(yard, data.ship_id, preload: [:ship]),
           :ok <- company_can_afford_purchase?(company, stock) do
        ShipyardRepo.transfer_ship_to_company(stock, company)
      end
    end)
  end
end