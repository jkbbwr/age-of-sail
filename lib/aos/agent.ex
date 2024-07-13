defmodule Aos.Agent do
  @callback topics() :: [String.t()]
  @callback tick(any, any) :: {:noreply, any}

  defmacro __using__(_) do
    quote do
      alias Phoenix.PubSub
      use GenServer
      @behaviour Aos.Agent

      @impl true
      def init(state) do
        if function_exported?(__MODULE__, :tick, 1) do
          PubSub.subscribe(Aos.PubSub, "tick")
        end

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
