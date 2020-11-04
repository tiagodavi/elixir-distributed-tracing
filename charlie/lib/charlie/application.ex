defmodule Charlie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    _ = OpenTelemetry.register_application_tracer(:charlie)

    children = [
      # Starts a worker by calling: Charlie.Worker.start_link(arg)
      # {Charlie.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Charlie.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
