defmodule AosWeb.PlayerControllerTest do
  use AosWeb.ConnCase, async: true
  alias Aos.Service.RegisterPlayer
  import AosWeb.Factory

  test "register new account" do
    conn =
      post(build_conn(), ~p"/api/player/register", %{
        email: "example@example.com",
        name: "Bob",
        password: "password"
      })

    assert json_response(conn, 201)["data"]["name"] == "Bob"
  end

  describe "registration error cases" do
    test "user already exists" do
      # Create a user.
      player = insert!(:player)

      conn =
        post(build_conn(), ~p"/api/player/register", %{
          email: player.email,
          name: "fucking bob",
          password: "password"
        })

      assert json_response(conn, 400) == %{"errors" => %{"email" => ["has already been taken"]}}
    end

    test "password not strong enough" do
      conn =
        post(build_conn(), ~p"/api/player/register", %{
          email: "example@example.com",
          name: "bob",
          password: "123"
        })

      assert json_response(conn, 400) == %{
               "errors" => %{"password" => ["should be at least 8 character(s)"]}
             }
    end
  end
end
