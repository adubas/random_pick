defmodule RandomPick.Lotteries.LotteriesOngoingPoller do
  @moduledoc """
    Fetch all ongoing lotteries and enqueued them
  """

  use Oban.Worker, queue: :draw_lottery_poller

  alias RandomPick.Lotteries
  alias RandomPick.Lotteries.DrawLotteryWorker

  @impl Oban.Worker
  def perform(_) do
    case Lotteries.fetch_ongoing_lotteries_ids() do
      [] ->
        {:ok, nil}

      lotteries_ids ->
        lotteries_ids
        |> Enum.each(fn lottery_id ->
          lottery = Lotteries.fetch_lottery(lottery_id)

          %{lottery_id: lottery_id}
          |> DrawLotteryWorker.new(scheduled_at: lottery.draw_date)
          |> Oban.insert()
        end)

        {:ok, lotteries_ids}
    end
  end
end
