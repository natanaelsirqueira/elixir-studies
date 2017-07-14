defmodule Link do
  import :timer, only: [ sleep: 1 ]

  def send_msg_to(parent) do
    send parent, {:text, "Message to send..."}
    send parent, {:add, 3, 5}
    send parent, {:text, "Another message..."}
    # exit(:boom)
    raise("Nothing to send yet")
  end

  def loop do
    receive do
      {:text, msg} ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        loop()
      {:add, a, b} ->
        IO.puts "Sum received: #{a + b}"
        loop()
      # {:EXIT, pid, reason} ->
      #   IO.puts "Process #{inspect(pid)} died because of #{inspect(reason)}"
    after 500 ->
      IO.puts "Nothing happened as far as I am concerned"
    end
  end

  def run do
    Process.flag(:trap_exit, true)
    # spawn_link(Link, :send_msg_to, [self()])
    res = spawn_monitor(Link, :send_msg_to, [self()])
    IO.puts inspect res

    sleep(500)

    loop()
  end
end

Link.run()
