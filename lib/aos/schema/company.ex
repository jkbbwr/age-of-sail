defmodule Aos.Schema.Company do
  use Aos.Schema

  schema "company" do
    field :ticker, :string
    field :name, :string
    belongs_to :player, Aos.Schema.Player
    has_many :ships, Aos.Schema.Ship
    timestamps()
  end

  def changeset(player, attrs \\ %{}) do
    player
    |> cast(attrs, [:ticker, :name])
    |> put_assoc(:player, attrs.player)
    |> validate_required([:ticker, :name])
    |> unique_constraint([:ticker])
    |> validate_length(:ticker, min: 3, max: 5)
  end
end
