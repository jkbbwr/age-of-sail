defmodule AosWeb.AuthControllerTest do
  use AosWeb.ConnCase, async: true
  alias Aos.Service.RegisterPlayer
  import AosWeb.Factory

  describe "a typical auth flow" do
    test "get a token for a registered player" do
      player = insert!(:player)

      conn =
        post(build_conn(), ~p"/api/player/login", %{
          email: player.email,
          password: player.password
        })

      assert json_response(conn, 200)["data"]["player_id"] == player.id
    end
  end

  describe "auth failure cases" do
    test "good user bad password" do
      player = insert!(:player)

      conn =
        post(build_conn(), ~p"/api/player/login", %{email: player.email, password: "fuck you"})

      assert json_response(conn, 403) == %{"message" => "invalid password"}
    end

    test "no such user" do
      conn =
        post(build_conn(), ~p"/api/player/login", %{email: "doesnt@exist.com", password: "fuck"})

      assert json_response(conn, 403) == %{"message" => "invalid password"}
    end
  end
end
