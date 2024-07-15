defmodule Aos do
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def repository do
    quote do
      import Ecto.Query
      alias Aos.Repo
      alias Aos.Schema

      defp wrap_not_found(query) do
        case query do
          nil -> {:error, :not_found}
          found -> {:ok, found}
        end
      end
    end
  end
end
