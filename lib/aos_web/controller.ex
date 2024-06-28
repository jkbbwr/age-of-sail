defmodule AosWeb.Controller do
  defmacro __using__(_) do
    quote do
      use AosWeb, :controller
      action_fallback AosWeb.FallbackController
    end
  end
end
