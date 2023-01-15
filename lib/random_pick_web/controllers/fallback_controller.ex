defmodule RandomPickWeb.FallbackController do
  use RandomPickWeb, :controller

  alias RandomPickWeb.ErrorView

  def call(conn, {:error, error}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("errors.json", %{errors: error})
  end
end
