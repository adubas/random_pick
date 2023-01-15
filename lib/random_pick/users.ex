defmodule RandomPick.Users do
  @moduledoc """
    Module to handle with all User context
  """

  alias RandomPick.Repo
  alias RandomPick.Users.User

  def create(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
