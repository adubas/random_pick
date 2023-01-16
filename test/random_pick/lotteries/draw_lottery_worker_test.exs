defmodule RandomPick.Lotteries.DrawLotteryWorkerTest do
  use RandomPick.DataCase, async: true

  import RandomPick.Factory

  alias Ecto.UUID
  alias RandomPick.Lotteries.DrawLotteryWorker

  describe "perform/1" do
    test "returns updated lottery" do
      lottery = insert(:lottery)
      insert_list(5, :lottery_participant, lottery: lottery)

      {:ok, lottery} = perform_job(DrawLotteryWorker, %{"lottery_id" => lottery.id})

      assert lottery.winner_id
      assert lottery.available == false
    end

    test "returns nil when lottery does not exists" do
      {:ok, nil} = perform_job(DrawLotteryWorker, %{"lottery_id" => UUID.generate()})
    end
  end
end
