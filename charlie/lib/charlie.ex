defmodule Charlie do
  @moduledoc """
  Documentation for Charlie.
  """

  require OpenTelemetry.Tracer

  def get_account(params, parent_span) do
    OpenTelemetry.Tracer.with_span "charlie-span", %{parent: parent_span} do
      Process.sleep(123)
      params
    end
  end
end
