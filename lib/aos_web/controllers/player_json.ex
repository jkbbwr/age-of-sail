defmodule AosWeb.PlayerJSON do
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  def render("player.json", %{player: player}) do
    %{
      id: player.id,
      email: player.email
    }
  end
end
