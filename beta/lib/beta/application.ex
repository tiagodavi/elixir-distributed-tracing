defmodule Beta.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    _ = OpenTelemetry.register_application_tracer(:beta)

    children = [
      # Starts a worker by calling: Beta.Worker.start_link(arg)
      # {Beta.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Beta.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
