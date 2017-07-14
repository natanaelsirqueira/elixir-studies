defmodule Feeds.DataFormatter do

  def print_formatted_data(%{current_observation: data}) do
    IO.puts Enum.map_join(data, "\n", fn {key, value} ->
      "#{printable_key(key)}: #{value}"
    end)
  end

  defp printable_key(key) do
    key
    |> to_string
    |> String.replace("_", " ")
    |> String.capitalize
  end
end
