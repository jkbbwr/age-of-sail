defmodule Aos.Schema.Route do
  use Aos.Schema

  schema "route" do
    belongs_to :source, Aos.Schema.Port
    belongs_to :destination, Aos.Schema.Port
    field :description, :string
    field :length, :integer

    timestamps()
  end

  def changeset(route, attrs \\ %{}) do
    route
    |> cast(attrs, [:description, :length])
    |> put_assoc(:source, attrs.source)
    |> put_assoc(:destination, attrs.destination)
    |> validate_required([:description, :length])
    |> validate_number(:length, greater_than_or_equal_to: 1)
  end
end
