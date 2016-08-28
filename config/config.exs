# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :rally_hook_proxy, RallyHookProxy.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "2gzuUqWtFYCsj/4Fq32kYSLCwfbYjyxQY8KhXd/CptJuP3bgKaK/D96asiZ6hbfH",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: RallyHookProxy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "RallyHookProxy",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "asdfijfadf",
  serializer: RallyHookProxy.GuardianSerializer,
  permissions: %{
    default: [
      :read_profile,
      :write_profile,
      :read_token,
      :revoke_token,
    ],
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
