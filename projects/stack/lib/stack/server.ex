defmodule Stack.Server do
  use GenServer

  # External API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def push(element) do
    GenServer.cast __MODULE__, {:push, element}
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def shutdown do
    GenServer.call __MODULE__, :stop
  end

  # Implementation

  def init(stash_pid) do
    current_stack = Stack.Stash.get_stack stash_pid
    { :ok, {current_stack, stash_pid} }
  end

  def handle_call(:pop, _from, { [elem], stash_pid }) do
    { :stop, :normal, elem, { [], stash_pid } }
  end

  def handle_call(:pop, _from, { [elem | tail], stash_pid} ) do
    { :reply, elem, {tail, stash_pid} }
  end

  def handle_call(:stop, _from, state) do
    { :stop, :normal, :ok, state}
  end

  def handle_cast({ :push, elem }, { current_stack, stash_pid }) do
    { :noreply, { [elem | current_stack], stash_pid} }
  end

  def terminate(_reason, {current_stack, stash_pid}) do
    IO.puts "Encerrando stack..."
    Stack.Stash.save_stack stash_pid, current_stack
  end
end

# Stack.Server |> Process.whereis |> GenServer.stop
