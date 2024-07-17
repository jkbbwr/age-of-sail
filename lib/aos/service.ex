defmodule Aos.Service do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Aos.Service

      @behaviour Bodyguard.Policy
    end
  end

  defmacro changeset(payload, do: block) do
    quote do
      def validate(unquote(payload)) do
        changeset = unquote(block)

        if changeset.valid? do
          {:ok, changeset.changes}
        else
          {:error, changeset}
        end
      end
    end
  end
end
