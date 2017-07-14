defmodule Token do
  def send_token do
    receive do
      {sender, token} ->
        send sender, {self(), token}
    end
  end

  def run(token1, token2) do
    pid1 = spawn(Token, :send_token, [])
    pid2 = spawn(Token, :send_token, [])

    send pid1, {self, token1}
    send pid2, {self, token2}

    receive do
      {^pid1, token1} -> IO.puts "#{token1}"
    end

    receive do
      {^pid2, token2} -> IO.puts "#{token2}"
    end
  end
end

spawn(Token, :run, ["Hello", "World"])

:timer.sleep(3000)
