import Config


config :random_pick, RandomPick.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "database",
  database: "random_pick_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10


config :random_pick, RandomPickWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "SZTczKWPLnvsvJlxiHoSzvuIhCXNnnN6Ego880FydgN2N3s5Ui5TRGvsq/7sJ20u",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
