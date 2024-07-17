defmodule Aos.Schema.Port do
  use Aos.Schema

  schema "port" do
    field :name, :string
    field :shortcode, :string

    many_to_many :destinations, Aos.Schema.Port,
      join_through: Aos.Schema.Route,
      join_keys: [source_id: :id, destination_id: :id]

    has_many :ships, Aos.Schema.Ship
    has_one :shipyard, Aos.Schema.Shipyard
    has_many :agents, Aos.Schema.CompanyAgent
    has_many :warehouses, Aos.Schema.Warehouse

    timestamps()
  end

  def changeset(port, attrs \\ %{}) do
    port
    |> cast(attrs, [:name, :shortcode])
    |> validate_required([:name, :shortcode])
    |> validate_length(:shortcode, is: 4)
    |> unique_constraint(:shortcode)
    |> unique_constraint(:name)
    |> update_change(:shortcode, &String.downcase/1)
  end
end
