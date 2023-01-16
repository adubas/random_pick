defmodule RandomPick.Lotteries do
  @moduledoc """
    Module to handle with all Lottery context
  """

  alias RandomPick.Lotteries.{Lottery, LotteryParticipants}
  alias RandomPick.Repo

  def create(params) do
    params
    |> Lottery.changeset()
    |> Repo.insert()
  end

  def participate(params) do
    params
    |> LotteryParticipants.changeset()
    |> Repo.insert()
  end

  def result(id) do
    Lottery
    |> Repo.get_by(id: id)
    |> case do
      nil -> {:error, "Lottery not found"}
      lottery -> check_result(lottery)
    end
  end

  defp check_result(lottery) do
    if lottery.available == false do
      lottery = lottery |> Repo.preload(:winner)
      {:ok, lottery}
    else
      {:error, "Lottery result will be available in #{convert_date(lottery.draw_date)}"}
    end
  end

  defp convert_date(datetime) do
    datetime
    |> DateTime.to_date()
    |> Date.to_string()
  end
end
