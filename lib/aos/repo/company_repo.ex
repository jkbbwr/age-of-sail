defmodule Aos.Repo.CompanyRepo do
  use Aos, :repository
  alias Aos.Schema.Company

  @spec create(String.t(), String.t(), Aos.Schema.Player.t()) ::
          {:ok, Company.t()} | {:error, Ecto.Changeset.t()}
  def create(ticker, name, player) do
    %Company{}
    |> Company.changeset(%{ticker: ticker, name: name, player: player})
    |> Repo.insert()
  end

  def find_by_id(id) do
    case(Repo.get(Company, id)) do
      nil -> {:error, :not_found}
      company -> {:ok, company}
    end
  end

  def find_by_ticker(id) do
    case Repo.get_by(Company, ticker: id) do
      nil -> {:error, :not_found}
      company -> {:ok, company}
    end
  end
end
