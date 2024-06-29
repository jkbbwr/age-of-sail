defmodule Aos.Repo.PortRepo do
  use Aos, :repository
  alias Aos.Schema.Port

  def create(name, shortcode) do
    %Port{}
    |> Port.changeset(%{name: name, shortcode: shortcode})
    |> Repo.insert()
  end

  def find_by_name(name) do
    case Repo.get_by(Port, name: name) do
      nil -> {:error, :not_found}
      port -> {:ok, port}
    end
  end

  @spec find_by_id(Ecto.UUID.t()) :: {:ok, Port.t()} | {:error, :not_found}
  def find_by_id(id) do
    case(Repo.get(Port, id)) do
      nil -> {:error, :not_found}
      port -> {:ok, port}
    end
  end

  @spec find_by_shortcode(String.t()) :: {:ok, Port.t()} | {:error, :not_found}
  def find_by_shortcode(shortcode) do
    case Repo.get_by(Port, shortcode: String.downcase(shortcode)) do
      nil -> {:error, :not_found}
      port -> {:ok, port}
    end
  end
end
