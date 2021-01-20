# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gen_schemas_en,
  ecto_repos: [GenSchemasEn.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :gen_schemas_en, GenSchemasEnWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qvlM49+S1U/lWPVluZnUIQZkYTHNAWu2aZv6NdpedjSt54Dsj1CpDxC2P5QQ7i//",
  render_errors: [view: GenSchemasEnWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GenSchemasEn.PubSub,
  live_view: [signing_salt: "oi+WguDE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
