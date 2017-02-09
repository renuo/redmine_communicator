use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :redmine_communicator, RedmineCommunicator.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger,
  backends: [:console],
  compile_time_purge_level: :debug

# Configure your database
config :redmine_communicator, RedmineCommunicator.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "redmine_communicator_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
