defmodule Aos.Time do
  @epoch ~U[1600-01-01 00:00:00Z]
  @start ~U[2024-07-10 00:00:00Z]
  @scale 960

  @interval 90

  def gametime_to_datetime(gametime) do
    @epoch |> DateTime.add(gametime * @scale, :second)
  end

  def current_gametime(from \\ @start) do
    DateTime.now!("Etc/UTC")
    |> DateTime.truncate(:second)
    |> DateTime.diff(from)
  end

  def next_interval() do
    start = DateTime.to_unix(@start)
    passed = div(:os.system_time(:seconds) - start, @interval)
    next = start + (passed + 1) * @interval
    DateTime.from_unix!(next)
  end
end
