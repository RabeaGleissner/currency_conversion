import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :currency_conversion, CurrencyConversionWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "oD2iTw3EzqnaBWLR4MW4IIF/+sd535Tly9BP9P3dSSXT5mt1pU+wlRhRKFJYcbEo",
  server: false

# In test we don't send emails.
config :currency_conversion, CurrencyConversion.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
