defmodule Parse do
  def number(str), do: _number_digits(str,  0)

  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value)
  when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end
end

defmodule Expression do
  def calculate(expression) do
    {n1, [op | n2]} =
      expression
      |> Enum.reject(fn ch -> ch == ?\  end)
      |> Enum.split_while(fn ch -> ch in '0123456789' end)

    n1 = Parse.number(n1)
    n2 = Parse.number(n2)

    case op do
      ?+ -> n1 + n2
      ?- -> n1 - n2
      ?* -> n1 * n2
      ?/ -> n1 / n2
    end
  end
end

IO.inspect Expression.calculate('36 + 64')
IO.inspect Expression.calculate('12 * 20')
