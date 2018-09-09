# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :altstatus,
  ecto_repos: [Altstatus.Repo]

# Configures the endpoint
config :altstatus, AltstatusWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2+PzuJYZCpuJ/aIYz8/gqAB6lhZeIB5Cug9cqiS5xk7c/xp3H2fEWzlrPdorROuo",
  render_errors: [view: AltstatusWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Altstatus.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :cors_plug,
  origin: ["*"],
  max_age: 86400,
  methods: ["GET", "POST", "PUT"]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
