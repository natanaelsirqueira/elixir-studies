defmodule Feeds.NOAAFeeds do

  require Logger

  @user_agent  [ {"User-agent", "Elixir dave@pragprog.com"} ]

  @noaa_url Application.get_env(:feeds, :noaa_url)

  def fetch(station) do
    Logger.info "Fetching station #{station}"
    issues_url(station)
    |> Tesla.get(headers: @user_agent)
    |> handle_response
  end

  def issues_url(station) do
    "#{@noaa_url}/xml/current_obs/#{station}.xml"
  end

  def handle_response(%{status: 200, body: body}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    { :ok,    parse_xml(body) }
  end

  def handle_response(%{status: status,   body: body}) do
    Logger.error "Error #{status} returned"
    { :error, body }
  end

  defp parse_xml(body) do
    import SweetXml
    body
    |> parse
    |> xmap(current_observation: [
      ~x[//current_observation],
      credit: ~x[./credit/text()]s,
      credit_URL: ~x[./credit_URL/text()]s,
      location: ~x[./location/text()]s,
      station_id: ~x[./station_id/text()]s,
      observation_time: ~x[./observation_time/text()]s,
      weather: ~x[./weather/text()]s,
      temperature: ~x[./temperature_string/text()]s,
      relative_humidity: ~x[./relative_humidity/text()]i,
      visibility: ~x[./visibility_mi/text()]f
    ])
  end
end
