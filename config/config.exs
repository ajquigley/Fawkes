# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fawkes,
  ecto_repos: [Fawkes.Repo]

# Configures the endpoint
config :fawkes, FawkesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1FBHHhDnCx5PIIjv77iCWvK6Uz5t7Nls/UXAy0OskOqmMH4JC1HcemO8FdjNjD/O",
  render_errors: [view: FawkesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fawkes.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
