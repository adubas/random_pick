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
end
