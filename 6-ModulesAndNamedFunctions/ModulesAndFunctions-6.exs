defmodule Chop do
  def guess(actual, range \\ 1..1000)

  def guess(actual, a..b) do
    guess(actual, a..b, a + div(b - a, 2))
  end

  defp guess(actual, _a..b, guess) when actual > guess do
    IO.puts "It is #{guess}"
    guess(actual, (guess + 1)..b)
  end

  defp guess(actual, a.._b, guess) when actual < guess do
    IO.puts "It is #{guess}"
    guess(actual, a..(guess - 1))
  end

  defp guess(actual, _a.._b, guess) when actual == guess do
    IO.puts "#{guess}"
  end
end
