defmodule Aos.Schema.Ship do
  use Aos.Schema

  schema "ship" do
    field :name, :string
    field :type, Ecto.Enum, values: [:sloop, :brig, :frigate, :galleon, :ship_of_the_line]
    field :cargo_space, :integer
    field :state, Ecto.Enum, values: [:at_port, :at_sea, :destroyed]
    field :speed, :integer
    belongs_to :port, Aos.Schema.Port
    belongs_to :company, Aos.Schema.Company
    field :arriving_at, :utc_datetime
    timestamps()
  end

  def update_company_changeset(ship, %{company: company} = attrs) do
    ship
    |> cast(attrs, [])
    |> put_assoc(:company, company)
    |> validate_required([:company])
  end

  def update_port_changeset(ship, %{port: port} = attrs) do
    ship
    |> cast(attrs, [])
    |> put_assoc(:port, port)
    |> validate_required([:port])
  end

  def create_changeset(ship, attrs \\ %{}) do
    ship
    |> cast(attrs, [:name, :type, :cargo_space, :state, :arriving_at, :speed])
    |> put_assoc(:company, attrs.company)
    |> put_assoc(:port, attrs.port)
    |> validate_required([:name, :type, :cargo_space, :state, :port, :speed])
  end
end
