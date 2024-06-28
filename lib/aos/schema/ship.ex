defmodule Aos.Schema.Ship do
  use Aos.Schema

  schema "ship" do
    field :name, :string
    field :type, Ecto.Enum, values: [:sloop, :brig, :frigate, :galleon, :ship_of_the_line]
    field :cargo_space, :integer
    field :state, Ecto.Enum, values: [:in_port, :at_sea, :destroyed]
    belongs_to :port, Aos.Schema.Port
    belongs_to :owner, Aos.Schema.Company
    field :arriving_at, :utc_datetime
    timestamps()
  end

  def changeset(ship, attrs \\ %{}) do
    ship
    |> cast(attrs, [:name, :type, :cargo_space, :state, :arriving_at])
    |> put_assoc(:port, attrs.port)
    |> put_assoc(:owner, attrs.owner)
    |> validate_required([:name, :type, :cargo_space, :state, :port])
  end
end
