defmodule RandomPickWeb.UserController do
  use RandomPickWeb, :controller

  alias RandomPick.Users

  def create(conn, params) do
    with {:ok, user} <- Users.create(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", %{user: user})
    end
  end
end
