## How to do distributed tracing with Elixir

**Step 1:  Run Zipkin Server to store traces**

    docker run -d -p 9411:9411 openzipkin/zipkin

**Step 2: Create 3 different elixir applications**

    mix new alpha --sup
    mix new beta --sup
    mix new charlie --sup

**Step 3: Add the dependency of opentelemetry & zipkin_exporter to all three apps**

    {:opentelemetry, "~> 0.4.0"},
    {:opentelemetry_api, "~> 0.3.2"},
    {:opentelemetry_zipkin, "~> 0.2.0"}

**Step 4: Setup Config files for all three apps**

    import Config
    
    #-> config/config.exs
    config :opentelemetry,
        :processors,
        ot_batch_processor: %{
            exporter:
            {:opentelemetry_zipkin,
            %{
                address: 'http://localhost:9411/api/v2/spans',
                local_endpoint: %{service_name: "alpha"}
            }}
        }

**Step 5: Register the events in application.ex for all three apps**

    #-> lib/alpha/application.ex
    use Application
    def start(_type, _args) do
    _ = OpenTelemetry.register_application_tracer(:alpha)

**Step 6: Run all three apps**

    iex --sname alpha@localhost -S mix
    iex --sname beta@localhost -S mix
    iex --sname charlie@localhost -S mix

**Step 7: Run start_call function on alpha app**

    Alpha.start_call
It's going to call beta that is going to call charlie. 

**Step 8: Take a look at the Zipkin Server on Localhost**

    localhost:9411

You might need to filter your query to see the results; 

Useful Links: 
https://zipkin.io
https://blog.newrelic.com/product-news/what-is-opentelemetry/
https://guycoding.medium.com/demystifying-distributed-tracing-in-elixir-via-open-telemetry-zipkin-and-elastic-search-1876c254162d