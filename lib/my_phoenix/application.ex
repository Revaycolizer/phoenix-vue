defmodule MyPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyPhoenixWeb.Telemetry,
      MyPhoenix.Repo,
      {DNSCluster, query: Application.get_env(:my_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MyPhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MyPhoenix.Finch},
      # Start a worker by calling: MyPhoenix.Worker.start_link(arg)
      # {MyPhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      MyPhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
