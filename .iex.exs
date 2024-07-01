defmodule AliasHack do
  defmacro __using__(_) do
    modules =
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

    for module <- modules do
      quote do
        alias unquote(module)
      end
    end
  end
end

use AliasHack

{:ok, player} = PlayerRepo.find_by_email("demo@demo.com")
# {:ok, company} = CompanyRepo.find_by_ticker("test")
{:ok, london} = PortRepo.find_by_shortcode("lond")
london = Repo.preload(london, shipyard: :ships)
