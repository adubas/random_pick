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

  def result(conn, params) do
    with {:ok, id} <- validate_result_params(params),
         {:ok, lottery} <- Lotteries.result(id) do
      conn
      |> put_status(:ok)
      |> render("result.json", %{lottery: lottery})
    end
  end

  defp validate_result_params(%{"id" => id}) when is_binary(id) do
    if id == "", do: {:error, "Invalid params"}, else: {:ok, id}
  end

  defp validate_result_params(_), do: {:error, "Invalid params"}
end
