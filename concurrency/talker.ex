defmodule Talker do
  def loop do
    receive do
      {:greet, name} -> IO.puts("Hello #{name}")
      {:praise, name} -> IO.puts("#{name}, you're amazing")
      {:celebrate, name, age} ->
        IO.puts("Here's to another #{age} years, #{name}")
    end
    loop()
  end
end

pid = spawn(&Talker.loop/0)
send(pid, {:greet, "Huey"}) #=> Hello Huey
send(pid, {:praise, "Dewey"}) #=>  Dewey, you're amazing
send(pid, {:celebrate, "Louie", 16}) #=> Here's to another 16 years, Louie
Process.sleep(1000)
