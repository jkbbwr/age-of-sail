defmodule Aos.Repo.RouteRepo do
  use Aos, :repository
  alias Aos.Schema.Route

  def create(source, destination, description, length) do
    %Route{}
    |> Route.changeset(%{
      source: source,
      destination: destination,
      description: description,
      length: length
    })
    |> Repo.insert()
  end
end
