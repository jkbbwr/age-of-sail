defmodule Aos.Repo.PlayerRepo do
  use Aos, :repository
  alias Aos.Schema.Player

  def create(attrs) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end
end
