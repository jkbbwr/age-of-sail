defmodule Aos.Repo.PlayerRepo do
  use Aos, :repository
  alias Aos.Schema.Player

  def create(attrs) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  def find_by_email(email) do
    case Repo.get_by(Player, email: email) do
      nil -> {:error, :not_found}
      player -> {:ok, player}
    end
  end
end
