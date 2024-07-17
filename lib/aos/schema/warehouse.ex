defmodule Aos.Schema.Warehouse do
  use Aos.Schema

  schema "warehouse" do
    belongs_to :company, Aos.Schema.Company
    belongs_to :port, Aos.Schema.Port

    field :capacity, :integer

    timestamps()
  end

  def create(warehouse, attrs) do
    warehouse
    |> cast(attrs, [:capacity])
    |> put_assoc(:company, attrs.company)
    |> put_assoc(:port, attrs.port)
    |> validate_number(:capacity, greater_than_or_equal_to: 1, less_than_or_equal_to: 10000)
    |> unique_constraint([:company, :port],
      message: "a company can only have one warehouse per port"
    )
  end
end
