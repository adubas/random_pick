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
end
