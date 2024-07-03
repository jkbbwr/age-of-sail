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

  def update_treasury_changeset(company, attrs) do
    company
    |> cast(attrs, [:treasury])
    |> validate_number(:treasury, greater_than_or_equal_to: 0)
  end

  def create_changeset(company, attrs) do
    company
    |> cast(attrs, [:ticker, :name, :treasury])
    |> validate_required([:ticker, :name, :treasury])
    |> unique_constraint(:player)
    |> unique_constraint(:ticker)
    |> put_assoc(:player, attrs.player)
    |> validate_length(:ticker, min: 3, max: 5)
    |> validate_number(:treasury, greater_than_or_equal_to: 0)
    |> update_change(:ticker, &String.downcase/1)
  end
end
