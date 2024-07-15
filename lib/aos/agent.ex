defmodule Aos.Agent do
  @callback topics() :: [String.t()]
  @callback tick(any, any) :: {:noreply, any}

  defmacro __using__(_) do
    quote do
      alias Phoenix.PubSub
      use GenServer
      require Logger
      @behaviour Aos.Agent

      def start_link(state, opts \\ []) do
        GenServer.start_link(__MODULE__, state, opts)
      end

      @impl true
      def init(state) do
        PubSub.subscribe(Aos.PubSub, "tick")
        Enum.each(topics(), fn topic -> PubSub.subscribe(Aos.PubSub, topic) end)

        {:ok, state}
      end

      @impl true
      def handle_info({:tick, gametime}, state) do
        {:noreply, tick(gametime, state)}
      end

      def topics(), do: []
      def tick(_, _), do: :noop
      defoverridable topics: 0
      defoverridable tick: 2
    end
  end
end
