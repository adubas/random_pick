defmodule RandomPickWeb.LotteryView do
  use RandomPickWeb, :view

  def render("create.json", %{lottery: lottery}) do
    %{id: lottery.id}
  end

  def render("result.json", %{lottery: lottery}) do
    %{
      name: lottery.winner.name,
      email: lottery.winner.email
    }
  end
end
