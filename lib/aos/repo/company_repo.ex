defmodule Aos.Repo.CompanyRepo do
  use Aos, :repository
  alias Aos.Schema.Company

  def create(ticker, name, treasury, player) do
    company =
      %Company{}
      |> Company.create_changeset(%{
        ticker: ticker,
        name: name,
        treasury: treasury,
        player: player
      })
      |> Repo.insert()

    case company do
      {:ok, company} -> {:ok, Repo.preload(company, [:agents, :ships])}
      error -> error
    end
  end

  def all(params \\ %{}) do
    query =
      from company in Company,
        preload: [:player],
        select: company

    Repo.paginate(query, params)
  end

  def find_company_by_player_id(player_id) do
    case(Repo.get_by(Company, player_id: player_id)) do
      nil -> {:error, :not_found}
      company -> {:ok, company}
    end
  end

  def find_by_id(id, opts \\ []) do
    preload = Keyword.get(opts, :preload, [])

    case Repo.get(Company, id) |> Repo.preload(preload) do
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

  def debit(company, amount) do
    Company.update_treasury_changeset(company, %{treasury: company.treasury - amount})
    |> Repo.update()
  end
end
