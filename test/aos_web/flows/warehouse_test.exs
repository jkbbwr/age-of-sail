defmodule AosWeb.WarehouseTest do
  use AosWeb.ConnCase, async: true
  import AosWeb.Factory

  describe "warehouse" do
    test "can be created" do
      player = insert!(:player)
      company = insert!(:company, player: player)
      auth = insert!(:auth_token, player: player)
      agent = insert!(:company_agent, company: company)

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/warehouse/buy", %{agent_id: agent.id, capacity: 1000})

      assert response = json_response(conn, 201)

      assert %{
               "data" => %{
                 "capacity" => 1000,
                 "port" => %{"name" => "London", "shortcode" => "lond"}
               }
             } = response
    end

    @tag :skip
    test "capacity can be changed" do
    end

    test "can't be created with bad capacity" do
      player = insert!(:player)
      company = insert!(:company, player: player)
      auth = insert!(:auth_token, player: player)
      agent = insert!(:company_agent, company: company)

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/warehouse/buy", %{agent_id: agent.id, capacity: 50000})

      assert response = json_response(conn, 400)
    end

    test "can't be bought by another player using their agent" do
      player = insert!(:player)
      player2 = insert!(:player)
      company = insert!(:company, player: player)
      auth = insert!(:auth_token, player: player2)
      agent = insert!(:company_agent, company: company)

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/warehouse/buy", %{agent_id: agent.id, capacity: 100})

      assert %{} == json_response(conn, 400)
    end
  end
end
