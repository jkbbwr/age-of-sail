defmodule AosWeb.JsonViewHelpers do
  def map_assoc_if_loaded(map, assoc, key, transformer) do
    if Ecto.assoc_loaded?(assoc) do
      Map.put(map, key, transformer.(assoc))
    else
      map
    end
  end

  def page_meta(page) do
    %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end
end
