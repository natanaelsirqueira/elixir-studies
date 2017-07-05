defmodule Taxes do
  def calc_totals(orders, tax_rates) do
    Enum.map(orders, fn order ->

      # if order[:ship_to] in Keyword.keys(tax_rates) do
      #
      #   tax = Keyword.get(tax_rates, order[:ship_to]) * order[:net_amount]
      #   total = order[:net_amount] + tax
      # else()
      #   total = order[:net_amount]
      # end

      tax_rate = Keyword.get(tax_rates, order[:ship_to], 0)

      tax = order[:net_amount] * tax_rate

      total = order[:net_amount] + tax

      Keyword.put(order, :total, total)
    end)
  end
end

defmodule SalesFile do
  def read(name) do
    file = File.read!(name)

    [header | body] = String.split(file, "\n", trim: true)

    header =
      header
      |> String.split(",")
      |> Enum.map(& String.to_atom(&1))

    body
    |> Stream.map(fn elem -> String.split(elem, ",") end)
    |> Stream.map(fn elem -> Enum.zip(header, elem) end)
    |> Enum.map(fn elem ->
      elem
      |> update_in([:id], &String.to_integer/1)
      |> update_in([:ship_to], fn(ship_to) ->
        ship_to
        |> String.replace(":", "")
        |> String.to_atom()
      end)
      |> update_in([:net_amount], &String.to_float/1)
    end)
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

IO.inspect Taxes.calc_totals(SalesFile.read("orders.txt"), tax_rates)
