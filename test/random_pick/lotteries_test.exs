defmodule RandomPick.LotteriesTest do
  use RandomPick.DataCase, async: true

  import RandomPick.Factory

  alias RandomPick.Lotteries

  describe "fetch_ongoing_lotteries_ids/0" do
    test "when there is none lottery that matches the criteria" do
      insert(:lottery, available: false)

      assert [] == Lotteries.fetch_ongoing_lotteries_ids()
    end

    test "when there is lotteries that matches the criteria" do
      date = DateTime.add(DateTime.now!("Etc/UTC"), -604_800, :second)
      [l1, l2, l3, l4] = insert_list(4, :lottery, deadline_date: date)
      insert_list(4, :lottery, available: false)

      assert [l1.id, l2.id, l3.id, l4.id] == Lotteries.fetch_ongoing_lotteries_ids()
    end
  end
end
