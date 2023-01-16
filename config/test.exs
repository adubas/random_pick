import Config

config :random_pick, RandomPick.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "database",
  database: "random_pick_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :random_pick, RandomPickWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "p38S+orbQBjeeOxO9Jt7OeyjCe2j3layqz5xAhui1bB9S+ziPKhitt9o0oEtyyAn",
  server: false

config :random_pick, RandomPick.Mailer, adapter: Swoosh.Adapters.Test

config :random_pick, Oban, testing: :manual

config :logger, level: :warn

config :phoenix, :plug_init_mode, :runtime
