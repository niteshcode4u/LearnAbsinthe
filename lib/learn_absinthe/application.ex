defmodule LearnAbsinthe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LearnAbsintheWeb.Telemetry,
      LearnAbsinthe.Repo,
      {DNSCluster, query: Application.get_env(:learn_absinthe, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LearnAbsinthe.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LearnAbsinthe.Finch},
      # Start a worker by calling: LearnAbsinthe.Worker.start_link(arg)
      # {LearnAbsinthe.Worker, arg},
      # Start to serve requests, typically the last entry
      LearnAbsintheWeb.Endpoint,
      {Absinthe.Subscription, LearnAbsintheWeb.Endpoint},
      LearnAbsinthe.Workers.AuthorWorker,
      LearnAbsinthe.Workers.PostWorker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LearnAbsinthe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LearnAbsintheWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
