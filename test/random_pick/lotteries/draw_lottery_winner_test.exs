defmodule RandomPick.Lotteries.DrawLotteryWinnerTest do
  use RandomPick.DataCase, async: true

  import RandomPick.Factory

  alias RandomPick.Lotteries.DrawLotteryWinner

  describe "call/1" do
    test "update lottery" do
      lottery = insert(:lottery)
      winner = insert(:user)
      insert(:lottery_participant, user: winner, lottery: lottery)

      assert {:ok, lottery} = DrawLotteryWinner.call(lottery)

      assert lottery.winner_id == winner.id
      assert lottery.available == false
    end

    test "update lottery with couple of participants" do
      lottery = insert(:lottery)
      insert_list(5, :lottery_participant, lottery: lottery)

      assert {:ok, lottery} = DrawLotteryWinner.call(lottery)

      assert lottery.winner_id
      assert lottery.available == false
    end
  end
end
