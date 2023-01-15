defmodule RandomPick.Lotteries.LotteryParticipantsTest do
  use RandomPick.DataCase, async: true

  import RandomPick.Factory

  alias Ecto.UUID
  alias RandomPick.Lotteries.LotteryParticipants

  describe "changeset/2" do
    test "when params are invalid" do
      params = %{
        user_id: 123,
        lottery_id: 123
      }

      changeset = LotteryParticipants.changeset(params)

      assert changeset.valid? == false

      assert errors_on(changeset) == %{
               user_id: ["is invalid"],
               lottery_id: ["is invalid"]
             }
    end

    test "when required params are missing" do
      changeset = LotteryParticipants.changeset(%{})

      assert changeset.valid? == false

      assert errors_on(changeset) == %{
               user_id: ["can't be blank"],
               lottery_id: ["can't be blank"]
             }
    end

    test "when params are valid" do
      params = %{
        user_id: UUID.generate(),
        lottery_id: UUID.generate()
      }

      changeset = LotteryParticipants.changeset(params)

      assert changeset.valid?
    end

    test "ensures that user is a valid user" do
      lottery = insert(:lottery)

      params = %{
        user_id: UUID.generate(),
        lottery_id: lottery.id
      }

      assert {:error, changeset} =
               params
               |> LotteryParticipants.changeset()
               |> Repo.insert()

      assert errors_on(changeset) == %{
               user: ["does not exist"]
             }
    end

    test "ensures that lottery is a valid lottery" do
      user = insert(:user)

      params = %{
        user_id: user.id,
        lottery_id: UUID.generate()
      }

      assert {:error, changeset} =
               params
               |> LotteryParticipants.changeset()
               |> Repo.insert()

      assert errors_on(changeset) == %{
               lottery: ["does not exist"]
             }
    end

    test "ensures user and lottery uniqueness" do
      lottery_participant = insert(:lottery_participant)

      params = %{
        user_id: lottery_participant.user_id,
        lottery_id: lottery_participant.lottery_id
      }

      assert {:error, changeset} =
               params
               |> LotteryParticipants.changeset()
               |> Repo.insert()

      assert errors_on(changeset) == %{
               lottery_id: ["has already been taken"]
             }
    end
  end
end
