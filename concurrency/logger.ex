defmodule MyLogger do
  def start_link do
    spawn(__MODULE__, :init, [0])
  end

  def init(count) do
    loop(count)
  end

  def loop(count) do
    new_count = receive do
      {:log, msg} ->
        IO.puts msg
        count + 1
      {:stats} ->
        IO.puts "I've logged #{count} messages"
        count
    end
    loop(new_count)
  end
end

pid = MyLogger.start_link
send(pid, {:log, "First message"})
send(pid, {:log, "Another message"})
send(pid, {:stats})
