defmodule AosWeb.PortJSON do
  def port(port) do
    %{
      id: port.id,
      name: port.name,
      shortcode: port.shortcode
    }
  end
end
