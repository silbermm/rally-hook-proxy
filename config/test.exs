use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rally_hook_proxy, RallyHookProxy.Endpoint,
  http: [port: 4001],
  server: false

config :rally_hook_proxy,
  rally_webhooks: RallyHookProxy.FakeWebhooks

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :rally_hook_proxy, RallyHookProxy.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rally_hook_proxy_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
