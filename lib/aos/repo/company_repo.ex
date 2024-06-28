defmodule Aos.Repo.CompanyRepo do
  use Aos, :repository
  alias Aos.Schema.Company

  """
  schema "company" do
    field :ticker, :string
    field :name, :string
    belongs_to :player, Aos.Schema.Player
    has_many :ships, Aos.Schema.Ship
    timestamps()
  end
  """

  def create(ticker, name, player) do
    %Company{}
    |> Company.changeset(%{ticker: ticker, name: name, player: player})
    |> Repo.insert()
  end
end
