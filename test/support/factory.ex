defmodule AosWeb.Factory do
  alias Aos.Repo
  alias Aos.Schema.{Player, Company, AuthToken, CompanyAgent, Shipyard, ShipyardStock, Ship}
  alias Aos.Repo.PortRepo
  use RandomPassword

  def build(:player) do
    %Player{
      name: Faker.Person.first_name(),
      email: Faker.Internet.email(),
      password_hash: Argon2.hash_pwd_salt(generate())
    }
  end

  def build(:company) do
    %Company{
      name: Faker.Company.name(),
      ticker: Faker.Util.format("%5a"),
      treasury: 9_999_999,
      player: build(:player)
    }
  end

  def build(:auth_token) do
    %AuthToken{
      token: Faker.Util.format("%64a"),
      player: build(:player),
      expires_at: DateTime.now!("Etc/UTC") |> DateTime.add(1, :hour) |> DateTime.truncate(:second)
    }
  end

  def build(:ship) do
    %Ship{
      name: Faker.Util.format("test ship %2a"),
      type: :sloop,
      cargo_space: 100,
      port: build(:london),
      state: :at_port,
      speed: 8,
      company: nil,
      arriving_at: nil
    }
  end

  def build(:shipyard_stock) do
    %ShipyardStock{
      ship: build(:ship),
      shipyard: build(:shipyard),
      cost: 100
    }
  end

  def build(:shipyard) do
    %Shipyard{
      port: build(:london),
      ships: []
    }
  end

  def build(:company_agent) do
    %CompanyAgent{
      company: build(:company),
      port: build(:london)
    }
  end

  def build(:london) do
    {:ok, london} = PortRepo.find_by_shortcode("lond")
    london
  end

  def build(:london_shipyard) do
    london = build(:london) |> Repo.preload([:shipyard])
    london.shipyard |> Repo.preload(ships: :ship)
  end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
