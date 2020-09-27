# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :incident_report,
  ecto_repos: [IncidentReport.Repo]

# Configures the endpoint
config :incident_report, IncidentReportWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+F1Q54mcVLeDtTn+wFpLKFY/7tnTwm5YePaBlWv9mY5cG0+pHphq2Yqm1OgLVqrK",
  render_errors: [view: IncidentReportWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: IncidentReport.PubSub,
  live_view: [signing_salt: "kFdf81P3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
