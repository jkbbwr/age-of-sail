true =
  :application.get_key(:aos, :modules)
  |> elem(1)
  |> Enum.map(&Module.split/1)
  |> Enum.filter(fn
    ["Aos", "Service" | _] ->
      true

    ["Aos", "Repo" | _] ->
      true

    _ ->
      false
  end)
  |> Enum.map(&Module.safe_concat/1)
  |> Enum.map(&Mimic.copy/1)
  |> Enum.all?(&(&1 == :ok))

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Aos.Repo, :manual)
