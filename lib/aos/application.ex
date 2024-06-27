defmodule Aos.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AosWeb.Telemetry,
      Aos.Repo,
      {DNSCluster, query: Application.get_env(:aos, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Aos.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Aos.Finch},
      # Start a worker by calling: Aos.Worker.start_link(arg)
      # {Aos.Worker, arg},
      # Start to serve requests, typically the last entry
      AosWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Aos.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AosWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
