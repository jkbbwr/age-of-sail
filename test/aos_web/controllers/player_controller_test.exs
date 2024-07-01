defmodule AosWeb.PlayerControllerTest do
  use AosWeb.ConnCase, async: true
  alias Aos.Service.RegisterPlayer

  test "register new account" do
    conn =
      post(build_conn(), ~p"/api/player/register", %{
        email: "example@example.com",
        password: "password"
      })

    assert json_response(conn, 200)["data"]["email"] == "example@example.com"
  end

  describe "registration error cases" do
    test "user already exists" do
      # Create a user.
      {:ok, _} = RegisterPlayer.call(%{email: "example@example.com", password: "password"})

      conn =
        post(build_conn(), ~p"/api/player/register", %{
          email: "example@example.com",
          password: "password"
        })

      assert json_response(conn, 422) == %{"errors" => %{"email" => ["has already been taken"]}}
    end

    test "password not strong enough" do
      conn =
        post(build_conn(), ~p"/api/player/register", %{
          email: "example@example.com",
          password: "123"
        })

      assert json_response(conn, 422) == %{
               "errors" => %{"password" => ["should be at least 8 character(s)"]}
             }
    end
  end
end
