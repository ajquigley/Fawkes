use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fawkes, FawkesWeb.Endpoint,
  http: [port: 4001],
  server: false

config :fawkes, FawkesWeb.Guardian.Tokenizer,
                issuer: "fawkes",
                secret_key: "our random string"

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :fawkes, Fawkes.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "fawkes_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
