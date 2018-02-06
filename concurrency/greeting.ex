defmodule Greeting do
  def loop do
    receive do
      {:hello, name} -> IO.puts "Hello, #{name}."
      {:bye  , name} -> IO.puts "Bye, #{name}."
    end
  end
end

pid = spawn(Greeting, :loop, [])

send(pid, {:hello, "Natanael"})
