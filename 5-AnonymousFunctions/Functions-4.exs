prefix = fn p -> (
  fn name ->
    IO.puts "#{p} #{name}"
    IO.puts to_string(p) <> " " <> to_string(name)
  end
  )
end

mrs = prefix.("Mrs")

mrs.("Smith")

prefix.("Elixir").("Rocks")
