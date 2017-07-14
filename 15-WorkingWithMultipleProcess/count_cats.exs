defmodule CountCats do

  def count(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :count, file, client } ->
        send client, { :answer, file, count_cats(file), self() }
        count(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def count_cats(file) do
    File.stream!(file, read_ahead: 1000)
    |> Stream.flat_map(&String.split(&1, [" ", "\n"], trim: true))
    |> Enum.count(fn word -> word == "cat" end)
  end

end

defmodule Scheduler do
  def run(num_processes, module, func, files) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(files, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:count, next, self()}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end

      {:answer, file, result, _pid} ->
        schedule_processes(processes, queue, [ {file, result} | results ])
    end
  end
end

IO.inspect File.cd!("test-files")
IO.inspect files = File.ls!

Enum.each 1..20, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, CountCats, :count, files]
  )
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
end
