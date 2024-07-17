defmodule AosWeb.FallbackController do
  use AosWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(AosWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(AosWeb.ErrorJSON)
    |> render(:unauthorized)
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(AosWeb.ErrorJSON)
    |> render(:forbidden)
  end

  def call(conn, {:error, :invalid_password}) do
    conn
    |> put_status(:forbidden)
    |> put_view(AosWeb.ErrorJSON)
    |> render(:invalid_password)
  end

  def call(_conn, error) do
    raise "fallback error not implemented for #{inspect(error)}"
  end
end
