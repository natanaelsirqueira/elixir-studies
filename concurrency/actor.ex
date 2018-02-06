defmodule MyActor do
  def loop do
    receive do
      msg -> IO.puts msg
    end
    loop()
  end
end

pid = spawn(MyActor, :loop, [])

send(pid, "First message")
send(pid, "Another message")
Process.sleep(1000)
