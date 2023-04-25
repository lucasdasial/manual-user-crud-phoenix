defmodule PhxDelivery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxDeliveryWeb.Telemetry,
      # Start the Ecto repository
      PhxDelivery.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxDelivery.PubSub},
      # Start Finch
      {Finch, name: PhxDelivery.Finch},
      # Start the Endpoint (http/https)
      PhxDeliveryWeb.Endpoint
      # Start a worker by calling: PhxDelivery.Worker.start_link(arg)
      # {PhxDelivery.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxDelivery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxDeliveryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
