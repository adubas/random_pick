defmodule RandomPick.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RandomPick.Repo,
      RandomPickWeb.Telemetry,
      {Oban, Application.fetch_env!(:random_pick, Oban)},
      {Phoenix.PubSub, name: RandomPick.PubSub},
      RandomPickWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: RandomPick.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    RandomPickWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
