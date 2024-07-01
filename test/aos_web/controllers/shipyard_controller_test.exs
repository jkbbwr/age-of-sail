defmodule AosWeb.ShipyardControllerTest do
  use AosWeb.ConnCase, async: true
  import AosWeb.Factory

  test "get all shipyards" do
    player = insert!(:player)
    company = insert!(:company, player: player)
    auth = insert!(:auth_token, player: player)

    {:ok, london} = PortRepo.find_by_shortcode("lond")

    conn =
      authenticated_json_conn(auth.token)
      |> post(~p"/api/agent/hire", %{company_id: company.id, port_id: london.id})

    conn =
      get(build_conn(), ~p"/api/shipyard")

    assert json_response(conn, 200) == []
  end
end
