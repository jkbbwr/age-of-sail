defmodule Aos.Service.TransitShip do
  use Aos.Service

  alias Aos.Repo.ShipRepo

  embedded_schema do
    field :ship_id, Ecto.UUID
    field :destination_id, Ecto.UUID
  end

  changeset payload do
    %__MODULE__{}
    |> cast(payload, [:ship_id, :destination_id])
    |> validate_required([:ship_id, :destination_id])
  end

  def authorize(:call, %{}, %{ship: ship}) when ship.state == :at_sea,
    do: {:error, Aos.Error.ShipAtSea.new(%{})}

  def authorize(:call, %{}, %{ship: ship, company: company})
      when ship.company_id != company.id,
      do: {:error, Aos.Error.ShipNotOwnedByCompany.new(%{})}

  def authorize(:call, %{player: player}, %{company: company})
      when company.player_id != player.id,
      do: {:error, Aos.Error.CompanyNotOwnedByPlayer.new(%{})}

  def authorize(:call, _, _), do: true

  def call(player, payload) do
    with {:ok, args} <- validate(payload),
         {:ok, ship} <- ShipRepo.find_by_id(args.ship_id, preload: [:company]),
         :ok <- Bodyguard.permit(__MODULE__, :call, player, company: ship.company) do
    end
  end
end
