defmodule RandomPick.Lotteries.LotteriesOngoingPollerTest do
  use RandomPick.DataCase, async: true

  import RandomPick.Factory

  alias RandomPick.Lotteries.{DrawLotteryWorker, LotteriesOngoingPoller}

  describe "perform/1" do
    test "when there is none ongoing lottery" do
      assert {:ok, nil} = perform_job(LotteriesOngoingPoller, %{})

      refute_enqueued(worker: DrawLotteryWorker)
    end

    test "when there is ongoing lottery" do
      date = DateTime.add(DateTime.now!("Etc/UTC"), -604_800, :second)
      draw = DateTime.add(DateTime.now!("Etc/UTC"), 604_800, :second)
      [l1, l2] = insert_list(2, :lottery, deadline_date: date, draw_date: draw)
      insert_list(4, :lottery, available: false)
      insert_list(5, :lottery_participant, lottery: l1)
      insert_list(2, :lottery_participant, lottery: l2)

      assert {:ok, [l1.id, l2.id]} == perform_job(LotteriesOngoingPoller, %{})

      assert_enqueued(worker: DrawLotteryWorker, args: %{lottery_id: l1.id})
      assert_enqueued(worker: DrawLotteryWorker, args: %{lottery_id: l2.id})
    end
  end
end
