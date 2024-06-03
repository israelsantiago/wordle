import Config

# docker run --name postgres -e POSTGRES_PASSWORD=postgres -d postgres;
#docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ex_wordle, ExWordle.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432",
  database: "ex_wordle_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex_wordle, ExWordleWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5pkouf+bgXILwWu0ImdeN+3NSnlGFeSrpUOx/Pv32pj/30FbQBym2A++3TaLAK8A",
  server: false

# In test we don't send emails.
config :ex_wordle, ExWordle.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true
