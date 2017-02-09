# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :redmine_communicator,
  ecto_repos: [RedmineCommunicator.Repo]

# Configures the endpoint
config :redmine_communicator, RedmineCommunicator.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "O93BTYuDKghaZD92EqEiDwSTGp5CkuhyXb70lkHjaLUxmERxO9jywrxqMWeSRAQF",
  render_errors: [view: RedmineCommunicator.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RedmineCommunicator.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :redmine_communicator, RedmineCommunicator.Mailer,
  adapter: Bamboo.SparkPostAdapter,
  api_key: System.get_env("SMTP_PASSWORD")

config :redmine_communicator, RedmineCommunicator.Email,
  sender_email: System.get_env("SENDER_EMAIL")

config :redmine_communicator, RedmineCommunicator.RedmineService,
  redmine_atom_key: System.get_env("REDMINE_ATOM_KEY"),
  redmine_url: System.get_env("REDMINE_URL")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"


