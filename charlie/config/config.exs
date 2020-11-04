import Config

config :opentelemetry,
    :processors,
    ot_batch_processor: %{
        exporter:
        {:opentelemetry_zipkin,
        %{
            address: 'http://localhost:9411/api/v2/spans',
            local_endpoint: %{service_name: "charlie"}
        }}
    }