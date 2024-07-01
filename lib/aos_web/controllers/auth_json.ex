defmodule AosWeb.AuthJSON do
  def render("auth.json", %{token: token}) do
    %{
      data: %{
        id: token.id,
        player_id: token.player_id,
        token: token.token
      }
    }
  end
end
