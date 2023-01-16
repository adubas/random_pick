defmodule RandomPickWeb.LotteryController do
  use RandomPickWeb, :controller

  alias RandomPick.Lotteries

  def create(conn, params) do
    with {:ok, lottery} <- Lotteries.create(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", %{lottery: lottery})
    end
  end

  def participate(conn, params) do
    with {:ok, _lottery_participant} <- Lotteries.participate(params) do
      resp(conn, :ok, "ok")
    end
  end
end
