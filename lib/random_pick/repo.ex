defmodule RandomPick.Repo do
  use Ecto.Repo,
    otp_app: :random_pick,
    adapter: Ecto.Adapters.Postgres
end
