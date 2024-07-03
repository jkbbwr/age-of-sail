defmodule AosWeb.EventWebsocketUpgrade do
  def init(handler), do: handler

  def call(conn, handler) do
    conn
    |> WebSockAdapter.upgrade(handler, %{}, [])
    |> Plug.Conn.halt()
  end
end
