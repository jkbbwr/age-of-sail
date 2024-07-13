defmodule AosWeb.EventWebsocket do
  require Logger
  alias Phoenix.PubSub
  @behaviour WebSock

  @impl true
  def init(_params) do
    PubSub.subscribe(Aos.PubSub, "user:123")
    state = %{}
    {:ok, state}
  end

  @impl true
  def handle_in(message, _state) do
    Logger.debug("Unhandled in. #{inspect(message)}")
  end

  @impl true
  def handle_info(payload, state) do
    {:push, {:text, Jason.encode!(payload)}, state}
  end
end
