defmodule Aos.Agent.GameTick do
  require Logger
  use GenServer
  alias Phoenix.PubSub

  @tickrate 90000

  def start_link(opts) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :sync_clock}}
  end

  @impl true
  def handle_continue(:sync_clock, state) do
    next_interval = Aos.Time.next_interval()

    timeout =
      DateTime.diff(
        next_interval,
        DateTime.now!("Etc/UTC") |> DateTime.truncate(:second),
        :millisecond
      )

    Logger.debug("Waiting til next valid interval #{next_interval}")
    Process.send_after(self(), :tick, timeout)
    {:noreply, state}
  end

  @impl true
  def handle_info(:tick, state) do
    timestamp = Aos.Time.current_gametime()
    PubSub.broadcast!(Aos.PubSub, "tick", {:tick, timestamp})

    Logger.debug(
      "Emitting game tick #{timestamp}. It is #{Aos.Time.gametime_to_datetime(timestamp)} in game. And #{DateTime.now!("Etc/UTC") |> DateTime.truncate(:second)} in the real world."
    )

    Process.send_after(self(), :tick, @tickrate)
    {:noreply, state}
  end
end
