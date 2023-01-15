defmodule RandomPick.Users.UserTest do
  use RandomPick.DataCase, async: true

  import RandomPick.Factory

  alias RandomPick.Repo
  alias RandomPick.Users.User

  describe "changeset/2" do
    test "when params are invalid" do
      params = %{
        name: 123,
        email: 123,
        password: false
      }

      changeset = User.changeset(params)

      assert changeset.valid? == false

      assert errors_on(changeset) == %{
               name: ["is invalid"],
               email: ["is invalid"],
               password: ["is invalid"]
             }
    end

    test "when required params are missing" do
      changeset = User.changeset(%{})

      assert changeset.valid? == false

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               email: ["can't be blank"],
               password: ["can't be blank"]
             }
    end

    test "when params are valid" do
      params = %{
        name: "John Doe",
        email: "valid@email.com",
        password: "safe_password_123"
      }

      changeset = User.changeset(params)

      assert changeset.valid?
    end

    test "ensures user uniqueness" do
      user = insert(:user)

      params = %{
        name: "John Doe",
        email: user.email,
        password: "safe_password_123"
      }

      assert {:error, changeset} =
               params
               |> User.changeset()
               |> Repo.insert()

      assert errors_on(changeset) == %{
               email: ["has already been taken"]
             }
    end
  end
end
