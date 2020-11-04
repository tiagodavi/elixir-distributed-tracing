defmodule Alpha do
  @moduledoc """
  Documentation for Alpha.
  """

  require OpenTelemetry.Tracer

  def start_call() do
    OpenTelemetry.Tracer.with_span "alpha-span" do
      delay = 100

      delay
      |> setup_data()
      |> perform_call_to_beta()
    end
  end

  # private functions

  # dummy function which assumes that you setup data
  # so we add some delay
  defp setup_data(delay) do
    %{
      user_id: 1234,
      user_name: "yatender-oktalk"
    }

    add_delay(delay)
  end

  defp perform_call_to_beta(params) do
    # we will fetch the current span context so that
    # we can pass it to next app, so next app can add
    # passed context as parent context.
    span_ctx = OpenTelemetry.Tracer.current_span_ctx()

    # we are passing 2 params in which second param is span information
    :rpc.call(:beta@localhost, Elixir.Beta, :get_account_info, [params, span_ctx])
  end

  # this function just add some delay
  defp add_delay(delay) do
    Process.sleep(delay)
  end
end
