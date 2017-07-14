defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "push item" do
    Stack.Server.push(1)
    { stack, pid } = :sys.get_state Stack.Server
    assert stack == [1, 0]
  end

  test "pop item" do
    Stack.Server.pop
  end
end
