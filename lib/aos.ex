defmodule Aos do
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def repository do
    quote do
      import Ecto.Query
      alias Aos.Repo
      alias Aos.Schema
    end
  end
end
