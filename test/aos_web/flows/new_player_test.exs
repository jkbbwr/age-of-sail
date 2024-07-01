defmodule AosWeb.NewPlayerTest do
  use AosWeb.ConnCase, async: true
  import AosWeb.Factory

  describe "new player flow" do
    test "joins game" do
      conn =
        post(build_conn(), ~p"/api/player/register", %{
          name: "example",
          email: "example@example.com",
          password: "password"
        })

      assert json_response(conn, 201)["data"]["name"] == "example"
    end

    test "creates a company" do
      player = insert!(:player)
      auth = insert!(:auth_token, player: player)

      player_id = player.id

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/company/register", %{name: "Test Company", ticker: "TEST"})

      assert response = json_response(conn, 201)

      assert %{
               "agents" => [],
               "ships" => [],
               "name" => "Test Company",
               "ticker" => "test",
               "player" => %{"id" => ^player_id}
             } = response["data"]
    end
  end
end
