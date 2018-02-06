defmodule MyEnum do
  def each(collection, fun) do
    Enum.reduce(collection, 0, fn(elem, _acc) -> fun.(elem) end)
  end

  def filter(collection, fun) do
    collection
    |> Enum.reduce([], fn(elem, acc) ->
      if fun.(elem) do
        [elem | acc]
      else
        acc
      end
    end)
    |> Enum.reverse
  end

  def map(collection, fun) do
    collection
    |> Enum.reduce([], fn(elem, acc) ->
      [fun.(elem) | acc]
    end)
    |> Enum.reverse
  end
end

collection = [1, 2, 3, 4, 5]

IO.inspect MyEnum.each(collection, fn(x) -> x + 1 end)
IO.inspect MyEnum.map(collection, fn(x) -> x + 1 end)
IO.inspect MyEnum.filter(collection, fn(x) -> rem(x,2) == 0 end)
