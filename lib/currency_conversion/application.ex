defmodule CurrencyConversion.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CurrencyConversionWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CurrencyConversion.PubSub},
      # Start the Endpoint (http/https)
      CurrencyConversionWeb.Endpoint,
      # Start a worker by calling: CurrencyConversion.Worker.start_link(arg)
      # {CurrencyConversion.Worker, arg}
      CurrencyConversion.ApiCache
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CurrencyConversion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CurrencyConversionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
