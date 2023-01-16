defmodule RandomPick.Lotteries.DrawLotteryWorker do
  @moduledoc false

  use Oban.Worker, queue: :draw_lottery_worker

  alias RandomPick.Lotteries
  alias RandomPick.Lotteries.DrawLotteryWinner

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"lottery_id" => lottery_id}}) do
    case Lotteries.fetch_lottery(lottery_id) do
      nil -> {:ok, nil}
      lottery -> DrawLotteryWinner.call(lottery)
    end
  end
end
