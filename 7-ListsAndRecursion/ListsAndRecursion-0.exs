defmodule ListModule do
  def range_to_list(a..b), do: Enum.map(a..b, &(&1))

  # def sum(list), do: _sum(list, 0)
  #
  # defp _sum([], total),             do: total
  # defp _sum([ head | tail], total), do: _sum(tail, head + total)

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def reduce([], value, _), do: value
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end
end

list = ListModule.range_to_list(1..10)

# IO.inspect ListModule.reduce(list, 1, &(&1 * &2))

# IO.inspect Enum.reduce([4, 9, 3, 6], &max/2)

bools = [true, false, true, true, false]

IO.inspect(Enum.reduce(bools, 0, fn
  (true, acc) -> acc
  (false, acc) -> acc + 1
end
) > 0)

IO.inspect Enum.reduce(list, {0, 1}, fn (current, {sum, product}) ->
  {sum + current, product * current}
end
)

IO.inspect !Enum.reduce(bools, &Kernel.&&/2)
