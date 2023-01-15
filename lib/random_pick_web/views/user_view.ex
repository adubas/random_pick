defmodule RandomPickWeb.UserView do
  use RandomPickWeb, :view

  def render("create.json", %{user: user}) do
    %{id: user.id}
  end
end
