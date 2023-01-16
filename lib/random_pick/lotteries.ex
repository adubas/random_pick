defmodule RandomPick.Lotteries do
  @moduledoc """
    Module to handle with all Lottery context
  """

  alias RandomPick.Lotteries.Lottery
  alias RandomPick.Repo

  def create(params) do
    params
    |> Lottery.changeset()
    |> Repo.insert()
  end
end
