defmodule RandomPick.Lotteries do
  @moduledoc """
    Module to handle with all Lottery context
  """

  import Ecto.Query

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

  def fetch_ongoing_lotteries_ids do
    Lottery
    |> where([l], l.available == ^true)
    |> where([l], is_nil(l.winner_id))
    |> where([l], l.deadline_date < ^DateTime.now!("Etc/UTC"))
    |> select([l], l.id)
    |> Repo.all()
  end

  def fetch_lottery(id) do
    Lottery
    |> Repo.get_by(id: id)
    |> Repo.preload([:owner, :participants])
  end

  def fetch_lottery_winner(lottery) do
    winner =
      lottery
      |> Repo.preload([:participants])
      |> Map.get(:participants)
      |> Enum.random()

    {:ok, winner}
  end

  def update_lottery_winner(lottery, winner) do
    lottery
    |> Repo.preload([:owner, :participants])
    |> Lottery.changeset(%{available: false, winner_id: winner.id})
  end
end
