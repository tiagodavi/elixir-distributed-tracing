defmodule Beta do
  @moduledoc """
  Documentation for Beta.
  """

  require OpenTelemetry.Tracer

  @doc """
  this application will receive the account data and
  parent span information
  """
  def get_account_info(params, parent_span) do
    OpenTelemetry.Tracer.with_span "beta-span", %{parent: parent_span} do
      span_ctx = OpenTelemetry.Tracer.current_span_ctx()
      :rpc.call(:charlie@localhost, Elixir.Charlie, :get_account, [params, span_ctx])
    end
  end
end
