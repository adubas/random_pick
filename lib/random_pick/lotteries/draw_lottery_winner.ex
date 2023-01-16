defmodule RandomPick.Lotteries.DrawLotteryWinner do
  @moduledoc """
    Select the winner of the lottery and closes the lottery
  """

  alias Ecto.Multi

  alias RandomPick.{Lotteries, Repo}

  def call(lottery) do
    Multi.new()
    |> Multi.run(:fetch_lottery_winner, fn _, _ -> Lotteries.fetch_lottery_winner(lottery) end)
    |> Multi.update(:update_lottery, fn %{fetch_lottery_winner: winner} ->
      Lotteries.update_lottery_winner(lottery, winner)
    end)
    |> Repo.transaction()
    |> handle_transaction()
  end

  defp handle_transaction({:ok, %{update_lottery: lottery}}), do: {:ok, lottery}
  defp handle_transaction({:error, _operation, reason, _changes}), do: {:error, reason}
end
