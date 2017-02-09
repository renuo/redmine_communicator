use Mix.Config

config :redmine_communicator, RedmineCommunicator.Mailer,
  api_key: "See Wiki"

config :redmine_communicator, RedmineCommunicator.RedmineService,
  redmine_atom_key: "See redmine",
  redmine_url: "redmine url"  