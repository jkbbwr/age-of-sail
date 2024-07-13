defmodule Aos.Repo.ItemRepo do
  use Aos, :repository
  alias Aos.Schema.Item

  def create(shortcode, name, description) do
    %Item{}
    |> Item.create(%{shortcode: shortcode, name: name, description: description})
    |> Repo.insert()
  end
end
