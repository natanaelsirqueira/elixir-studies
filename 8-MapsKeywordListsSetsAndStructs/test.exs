student = %{grades: %{final: 0.0, g1: %{nota: 8.8}, g2: %{nota: 9.5}}, name: "Natanael"}

busca_grades = fn :get_and_update, data, next ->
  {data.grades, next.(data.grades)}
end

IO.inspect update_in(student, [busca_grades], fn (grades) ->
  put_in(grades.final, Float.round((grades.g1 + grades.g2 * 2) / 3, 1))
end)


update_g1_g2 = fn
  :get, grades, next ->
    %{g1: next.(grades.g1), g2: next.(grades.g2)}

  :get_and_update, grades, next ->
    with \
      {g1, new_g1} <- next.(grades.g1),
      {g2, new_g2} <- next.(grades.g2)
    do
      grades_alteradas =
        grades
        |> put_in([:g1], new_g1)
        |> put_in([:g2], new_g2)

      {%{g1: g1, g2: g2}, grades_alteradas}
    end
end

IO.inspect update_in(student, [:grades, update_g1_g2, :nota], & &1 - 1)
IO.inspect get_in(student, [:grades, update_g1_g2, :nota])
IO.inspect get_and_update_in(student, [:grades, update_g1_g2, :nota], fn nota ->
  {nota + 1, nota - 2}
end)


keys = fn keys ->
  fn
    :get, data, next ->
      keys
      |> Enum.map(fn key ->
        {key, next.(data[key])}
      end)
      |> Enum.into(%{})

    :get_and_update, data, next ->
      Enum.reduce(keys, {%{}, data}, fn (key, {get, update}) ->
        {to_get, updated} = next.(data[key])

        {Map.put(get, key, to_get), Map.put(update, key, updated)}
      end)
  end
end

IO.inspect update_in(student, [:grades, keys.([:g1, :g2]), :nota], & &1 - 1)
IO.inspect get_in(student, [:grades, keys.([:g1, :g2]), :nota])
IO.inspect get_and_update_in(student, [:grades, keys.([:g1, :g2]), :nota], fn nota ->
  {nota + 1, nota - 2}
end)
