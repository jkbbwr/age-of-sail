defmodule Aos.Server.GameTick do
  use GenServer
  @behaviour GenServer

  def init(_opts) do
    {:ok, %{}}
  end
end
