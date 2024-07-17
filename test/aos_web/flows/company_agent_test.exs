defmodule AosWeb.CompanyAgentTest do
  use AosWeb.ConnCase, async: true
  import AosWeb.Factory

  describe "company agent" do
    test "can be hired" do
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

    test "can't be hired twice" do
      player = insert!(:player)
      company = insert!(:company, player: player)
      auth = insert!(:auth_token, player: player)
      london = build(:london)
      _agent = insert!(:company_agent, company: company, port: london)

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/agent/hire", %{port_id: london.id, company_id: company.id})

      assert json_response(conn, 400) == %{
               "errors" => %{"company_id" => ["company already has an agent in this port"]}
             }
    end
  end
end
