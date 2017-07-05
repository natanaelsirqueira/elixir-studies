defmodule ListModule do
  # ListsAndRecursion-1
  # it applies the passed function to each element of the list
  def mapsum([], _), do: 0
  def mapsum([head | tail], func) do
    func.(head) + mapsum(tail, func)
  end

  # ListsAndRecursion-2
  def max([a]), do: a
  def max([head | tail]), do: greater(head, max(tail)) # Kernel.max(head, max(tail))
  defp greater(a, b) when a > b, do: a
  defp greater(a, b) when b > a, do: b

  # ListsAndRecursion-3
  def caesar([], _n), do: []

  def caesar([ head | tail ], n)
    when head+n <= ?z,
    do: [ head+n | caesar(tail, n) ]

   def caesar([ head | tail ], n),
    do: [ head+n-26 | caesar(tail, n) ]

  # ListsAndRecursion-4
  def span(from, to), do: Enum.map(from..to, &(&1))

  def primes(list) do
    for x <- list, x == 2 || !Enum.any?(2..x-1, fn y -> rem(x,y) == 0 end), do: x
  end
end

IO.inspect ListModule.span(2, 10) |> ListModule.primes()
