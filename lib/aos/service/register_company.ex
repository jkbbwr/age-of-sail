defmodule Aos.Service.RegisterCompany do
  alias Aos.Repo.CompanyRepo

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
    field :ticker, :string
  end

  defp validate(payload) do
    changeset =
      %__MODULE__{}
      |> cast(payload, [:name, :ticker])
      |> validate_required([:name, :ticker])

    if changeset.valid? do
      {:ok, changeset.changes}
    else
      {:error, changeset}
    end
  end

  def call(player, payload) do
    with {:ok, data} <- validate(payload) do
      CompanyRepo.create(data.ticker, data.name, 1000, player)
    end
  end
end
