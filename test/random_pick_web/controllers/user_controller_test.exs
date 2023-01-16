defmodule RandomPickWeb.UserControllerTest do
  use RandomPickWeb.ConnCase, async: true

  import RandomPick.Factory

  alias RandomPick.Repo
  alias RandomPick.Users.User

  describe "POST /create_user" do
    test "returns error when params are invalid", %{conn: conn} do
      params = %{
        "name" => nil,
        "email" => nil,
        "password" => nil
      }

      path = Routes.user_path(conn, :create, params)

      assert %{
               "errors" => %{
                 "name" => ["can't be blank"],
                 "email" => ["can't be blank"],
                 "password" => ["can't be blank"]
               }
             } =
               conn
               |> post(path)
               |> json_response(:bad_request)
    end

    test "returns user id when params are valid", %{conn: conn} do
      params = %{
        "name" => "John Doe",
        "email" => "john@doe.com",
        "password" => "password"
      }

      path = Routes.user_path(conn, :create, params)

      assert %{"id" => id} =
               conn
               |> post(path)
               |> json_response(:ok)

      user = User |> Repo.get_by(id: id)

      assert user.email == "john@doe.com"
      assert user.name == "John Doe"
    end

    test "returns error when user already exist", %{conn: conn} do
      user = insert(:user)

      params = %{
        "name" => "John",
        "email" => user.email,
        "password" => "password"
      }

      path = Routes.user_path(conn, :create, params)

      assert %{
               "errors" => %{
                 "email" => ["has already been taken"]
               }
             } =
               conn
               |> post(path)
               |> json_response(:bad_request)
    end
  end
end
