defmodule Aos.Schema.Company do
  use Aos.Schema

  schema "company" do
    field :ticker, :string
    field :name, :string
    field :treasury, :integer
    belongs_to :player, Aos.Schema.Player
    has_many :ships, Aos.Schema.Ship
    has_many :agents, Aos.Schema.CompanyAgent
    timestamps()
  end

  def changeset(player, attrs \\ %{}) do
    player
    |> cast(attrs, [:ticker, :name, :treasury])
    |> put_assoc(:player, attrs.player)
    |> validate_required([:ticker, :name, :treasury])
    |> unique_constraint(:player)
    |> unique_constraint(:ticker)
    |> validate_length(:ticker, min: 3, max: 5)
    |> update_change(:ticker, &String.downcase/1)
  end
end
