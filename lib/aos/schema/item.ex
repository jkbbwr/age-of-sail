defmodule Aos.Schema.Item do
  use Aos.Schema

  schema "item" do
    field :shortcode, :string
    field :name, :string
    field :description, :string
    timestamps()
  end

  def create(item, attrs) do
    item
    |> cast(attrs, [:shortcode, :name, :description])
    |> validate_required([:shortcode, :name, :description])
    |> validate_length(:shortcode, min: 3, max: 5)
    |> update_change(:shortcode, &String.downcase/1)
    |> unique_constraint(:shortcode)
  end
end
