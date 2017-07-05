defmodule Error do
  def ok!({:ok, data}), do: data
  def ok!({:error, error}), do: raise("Exception: #{inspect error}")
end

IO.inspect Error.ok! File.read("file.txt")
