list = Enum.to_list(1..5)

defmodule MyEnum do
    def all?([], _func), do: true
    def all?([head | tail], func) do
      if func.(head) do
        all?(tail, func)
      else
        false
      end
    end

    def any?([], _func), do: false
    def any?([head | tail], func) do
      if func.(head) do
        true
      else
        any?(tail, func)
      end
    end

    def each([], _func), do: []
    def each([head | tail], func) do
      [func.(head) | each(tail, func)]
    end

    # Enum.filter(list, &(&1 > 2))
    def filter([], _func), do: []
    def filter([head | tail], func) do
      if (func.(head)) do
        [head | filter(tail, func)]
      else
        filter(tail, func)
      end
    end

    # Enum.split(list, 3)
    # {[1, 2, 3], [4, 5]}
    def split(list, count),      do: _split(list, [], count)
    defp _split([], front, _),   do: [ Enum.reverse(front), [] ]
    defp _split(tail, front, 0), do: [ Enum.reverse(front), tail ]
    defp _split([ head | tail ], front, count)  do
     _split(tail, [head|front], count-1)
    end

    # Enum.take(list, 3)
    # [1, 2, 3]
    def take(list, n), do: hd(split(list, n))
end

# IO.inspect MyEnum.all?(list, & &1 < 4)
# IO.inspect MyEnum.any?(list, & &1 < 4)
# IO.inspect MyEnum.each(list, & &1 > 2)
# IO.inspect MyEnum.filter(list, & &1 > 2)
IO.inspect MyEnum.split(list, 3)
# IO.inspect MyEnum.take(list, 3)
