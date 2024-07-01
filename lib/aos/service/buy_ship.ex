defmodule Aos.Service.BuyShip do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :agent_id, Ecto.UUID
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

  def call(payload) do
  end
end
