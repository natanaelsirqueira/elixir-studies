defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1,
                            sort_into_ascending_order: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort ascending orders the correct way" do
    assert ~w[a b c] ==
      ~w[c a b]
      |> Enum.map(& %{"created_at" => &1, "other_data" => "xxx"})
      |> sort_into_ascending_order()
      |> Enum.map(& Map.get(&1, "created_at"))
  end
end
