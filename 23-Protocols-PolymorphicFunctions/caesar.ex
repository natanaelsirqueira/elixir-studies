defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: [List, BitString] do
  def encrypt(string, shift) do
    string
    |> to_charlist
    |> Enum.map(fn char -> shift_char(char, shift)  end)
    |> List.to_string
  end

  defp shift_char(char, shift) do
    cond do
      is_upper?(char) -> rem(( (char - 65)  + shift), 26) + 65
      is_lower?(char) -> rem(( (char - 97) + shift), 26) + 97
      true -> char
    end
  end

  defp is_upper?(char) do
    char >= 65 && char <= 90
  end

  defp is_lower?(char) do
    char >= 97 && char <= 122
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

# IO.inspect Caesar.rot13("Why did the chicken cross the road?")
# IO.inspect Caesar.rot13("To get to the other side!")
words =
  File.stream!("/wordlists", [], :line)
  |> Enum.map(fn line -> line end)
  |> Enum.each(fn word ->
    if (Caesar.rot13(word) == word) do
      IO.puts word
    end
  end)

IO.inspect words

# words_by_size = for {len, group} <- Enum.group_by(words, &byte_size/1), into: Map.new do
#   {len, Enum.into(group, HashSet.new)}
# end

# words = File.stream
