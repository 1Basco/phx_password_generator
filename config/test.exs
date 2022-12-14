import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :password_generator, PasswordGenerator.Repo,
  username: "postgres",
  password: "1234",
  hostname: "localhost",
  database: "password_generator_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :password_generator, PasswordGeneratorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5+WX4vsapk8dXryhBHFF1c08SZ9tbQnA9vvgYR9xBwk4av2W5zr+wvCE95P/chAr",
  server: false

# In test we don't send emails.
config :password_generator, PasswordGenerator.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
