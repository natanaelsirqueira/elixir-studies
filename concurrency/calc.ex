defmodule Calc do
  def loop do
    receive do
      {:soma, n1, n2} -> IO.puts("Soma: #{n1 + n2}")
      {:sub , n1, n2} -> IO.puts("Subtração: #{n1 - n2}")
      {:mult, n1, n2} -> IO.puts("Multiplicação: #{n1 * n2}")
      {:div , n1, n2} -> IO.puts("Divisão: #{n1 / n2}")
    end
    loop()
  end
end

pid = spawn(&Calc.loop/0)
send(pid, {:soma, 6, 2}) #=> Soma: 8
send(pid, {:sub , 6, 2}) #=> Subtração: 4
send(pid, {:mult, 6, 2}) #=> Multiplicação: 12
send(pid, {:div , 6, 2}) #=> Divisão: 3.0
Process.sleep(1000)
