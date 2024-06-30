defmodule AosWeb.CompanyAgentControllerTest do
  use AosWeb.ConnCase, async: true
  alias Aos.Repo.PortRepo
  import AosWeb.Factory

  describe "agent common flow" do
    test "hire an agent" do
      player = insert!(:player)
      company = insert!(:company, player: player)
      auth = insert!(:auth_token, player: player)

      {:ok, london} = PortRepo.find_by_shortcode("lond")

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/agent/hire", %{company_id: company.id, port_id: london.id})

      assert response = json_response(conn, 201)
      assert response["company_id"] == company.id
      assert response["port_id"] == london.id
    end
  end

  describe "failure cases" do
    test "try to hire an agent for a company that player doesn't own" do
      player = insert!(:player)
      auth = insert!(:auth_token, player: player)

      company_i_dont_own = insert!(:company)

      {:ok, london} = PortRepo.find_by_shortcode("lond")

      conn =
        authenticated_json_conn(auth.token)
        |> post(~p"/api/agent/hire", %{company_id: company_i_dont_own.id, port_id: london.id})

      assert json_response(conn, 403) == %{"message" => "forbidden"}
    end
  end
end
