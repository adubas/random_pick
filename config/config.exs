import Config

config :random_pick,
  ecto_repos: [RandomPick.Repo],
  generators: [binary_id: true]

config :random_pick, RandomPick.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :random_pick, RandomPickWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: RandomPickWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: RandomPick.PubSub,
  live_view: [signing_salt: "S6I9q27t"]

config :random_pick, RandomPick.Mailer, adapter: Swoosh.Adapters.Local

config :random_pick, Oban,
  repo: RandomPick.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [
    draw_lottery_poller: 10,
    draw_lottery_worker: 10
  ],
  crontab: [
    {"@hourly", RandomPick.Lotteries.LotteriesOngoingPoller}
  ]

config :swoosh, :api_client, false

config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
