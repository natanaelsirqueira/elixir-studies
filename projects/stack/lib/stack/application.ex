defmodule Stack.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    { :ok, _pid} = Stack.Supervisor.start_link(Application.get_env(:stack, :initial_stack))
  end
end
