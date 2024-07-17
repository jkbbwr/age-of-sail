defmodule Aos.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children =
      [
        AosWeb.Telemetry,
        Aos.Repo,
        {DNSCluster, query: Application.get_env(:aos, :dns_cluster_query) || :ignore},
        {Phoenix.PubSub, name: Aos.PubSub},
        {Finch, name: Aos.Finch},
        AosWeb.Endpoint,
        Aos.TraderSupervisor
      ]
      |> gametick()

    opts = [strategy: :one_for_one, name: Aos.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp gametick(children) do
    if Application.fetch_env!(:aos, :enable_gametick) do
      children ++ [{Aos.Service.GameTick, name: Aos.GameTick}]
    else
      children
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AosWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
