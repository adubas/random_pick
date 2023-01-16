defmodule RandomPickWeb.LotteryView do
  use RandomPickWeb, :view

  def render("create.json", %{lottery: lottery}) do
    %{id: lottery.id}
  end
end
