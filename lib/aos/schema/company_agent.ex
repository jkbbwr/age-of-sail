defmodule Aos.Schema.CompanyAgent do
  use Aos.Schema

  schema "company_agent" do
    belongs_to :port, Aos.Schema.Port
    belongs_to :company, Aos.Schema.Company
    timestamps()
  end

  def changeset(ship, attrs \\ %{}) do
    ship
    |> cast(attrs, [])
    |> put_assoc(:port, attrs.port)
    |> put_assoc(:company, attrs.company)
    |> validate_required([:port, :company])
    |> unique_constraint([:port, :company])
  end
end