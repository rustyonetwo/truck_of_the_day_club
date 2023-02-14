defmodule TruckOfTheDayClub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TruckOfTheDayClub.Repo,
      # Start the Telemetry supervisor
      TruckOfTheDayClubWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TruckOfTheDayClub.PubSub},
      # Start the Endpoint (http/https)
      TruckOfTheDayClubWeb.Endpoint
      # Start a worker by calling: TruckOfTheDayClub.Worker.start_link(arg)
      # {TruckOfTheDayClub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TruckOfTheDayClub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TruckOfTheDayClubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
