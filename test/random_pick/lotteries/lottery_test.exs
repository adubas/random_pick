defmodule RandomPick.Lotteries.LotteryTest do
  use RandomPick.DataCase, async: true

  import RandomPick.Factory

  alias Ecto.UUID
  alias RandomPick.Lotteries.Lottery
  alias RandomPick.Repo

  describe "describe/2" do
    test "when params are invalid" do
      params = %{
        name: 123,
        description: 123,
        deadline_date: false,
        draw_date: DateTime.to_date(DateTime.now!("Etc/UTC")),
        available: "yes",
        owner_id: 123,
        winner_id: 123
      }

      changeset = Lottery.changeset(params)

      assert changeset.valid? == false

      assert errors_on(changeset) == %{
               name: ["is invalid"],
               description: ["is invalid"],
               deadline_date: ["is invalid"],
               draw_date: ["is invalid"],
               available: ["is invalid"],
               owner_id: ["is invalid"],
               winner_id: ["is invalid"]
             }
    end

    test "when required params are missing" do
      params = %{
        name: Faker.Lorem.characters(10) |> to_string(),
        description: Faker.Lorem.characters(50) |> to_string()
      }

      changeset = Lottery.changeset(params)

      assert changeset.valid? == false

      assert errors_on(changeset) == %{
               deadline_date: ["can't be blank"],
               draw_date: ["can't be blank"],
               owner_id: ["can't be blank"]
             }
    end

    test "when params are valid" do
      params = %{
        name: Faker.Lorem.characters(10) |> to_string(),
        description: Faker.Lorem.characters(50) |> to_string(),
        deadline_date: DateTime.add(DateTime.now!("Etc/UTC"), 604_800, :second),
        draw_date: DateTime.add(DateTime.now!("Etc/UTC"), 2_592_000, :second),
        owner_id: UUID.generate()
      }

      changeset = Lottery.changeset(params)

      assert changeset.valid?
    end

    test "ensures that owner is a valid user" do
      params = %{
        name: Faker.Lorem.characters(10) |> to_string(),
        description: Faker.Lorem.characters(50) |> to_string(),
        deadline_date: DateTime.add(DateTime.now!("Etc/UTC"), 604_800, :second),
        draw_date: DateTime.add(DateTime.now!("Etc/UTC"), 2_592_000, :second),
        owner_id: UUID.generate()
      }

      assert {:error, changeset} =
               params
               |> Lottery.changeset()
               |> Repo.insert()

      assert errors_on(changeset) == %{
               owner: ["does not exist"]
             }
    end

    test "ensures that winner is a valid user" do
      owner = insert(:user)

      params = %{
        name: Faker.Lorem.characters(10) |> to_string(),
        description: Faker.Lorem.characters(50) |> to_string(),
        deadline_date: DateTime.add(DateTime.now!("Etc/UTC"), 604_800, :second),
        draw_date: DateTime.add(DateTime.now!("Etc/UTC"), 2_592_000, :second),
        owner_id: owner.id,
        winner_id: UUID.generate()
      }

      assert {:error, changeset} =
               params
               |> Lottery.changeset()
               |> Repo.insert()

      assert errors_on(changeset) == %{
               winner: ["does not exist"]
             }
    end
  end
end
