defmodule Aos.Schema.Trader do
  use Aos.Schema

  schema "trader" do
    belongs_to :port, Aos.Schema.Port
    field :name, :string
    has_many :plans, Aos.Schema.TraderPlan
    timestamps()
  end

  def create(trader, attrs) do
    trader
    |> cast(attrs, [:name])
    |> put_assoc(:port, attrs.port)
  end
end
