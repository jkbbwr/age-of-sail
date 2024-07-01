defmodule AosWeb.NewPlayerTest do
  use AosWeb.ConnCase, async: true
  import AosWeb.Factory
  alias Aos.Repo.PortRepo

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

    test "company hires an agent" do
      player = insert!(:player)
      company = insert!(:company, player: player)
      auth = insert!(:auth_token, player: player)
      london = build(:london)

      company_id = company.id

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/agent/hire", %{port_id: london.id, company_id: company.id})

      assert response = json_response(conn, 201)
      assert %{"company" => %{"id" => ^company_id}} = response["data"]
    end

    test "player lists all shipyards" do
      player = insert!(:player)
      auth = insert!(:auth_token, player: player)

      conn =
        authenticated_json_conn(auth.token)
        |> get(~p"/api/shipyard")

      assert json_response(conn, 200)
    end

    test "player lists stock at specific shipyard" do
      player = insert!(:player)
      auth = insert!(:auth_token, player: player)
      company = insert!(:company, player: player)
      london_shipyard = build(:london_shipyard)

      conn =
        authenticated_json_conn(auth.token)
        |> get(~p"/api/shipyard/#{london_shipyard.id}")

      assert response = json_response(conn, 200)
      assert %{"ships" => [%{"ship" => %{"name" => "Demo Ship 1"}}]} = response["data"]
    end

    test "player decides to buy the ship at the shipyard" do
      player = insert!(:player)
      auth = insert!(:auth_token, player: player)
      company = insert!(:company, player: player)
      london = build(:london)
      london_shipyard = build(:london_shipyard)
      ship = List.first(london_shipyard.ships).ship
      agent = insert!(:company_agent, company: company, port: london)

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/shipyard/#{london_shipyard.id}/buy", %{
          ship_id: ship.id,
          agent_id: agent.id
        })
    end
  end
end
