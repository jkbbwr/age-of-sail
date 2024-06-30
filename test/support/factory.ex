defmodule AosWeb.Factory do
  alias Aos.Repo
  alias Aos.Schema.{Player, Company, AuthToken}
  use RandomPassword

  def build(:player) do
    %Player{email: Faker.Internet.email(), password_hash: Argon2.hash_pwd_salt(generate())}
  end

  def build(:company) do
    %Company{name: Faker.Company.name(), ticker: Faker.Util.format("%5a"), player: build(:player)}
  end

  def build(:auth_token) do
    %AuthToken{
      token: Faker.Util.format("%64a"),
      player: build(:player),
      expires_at: DateTime.now!("Etc/UTC") |> DateTime.add(1, :hour) |> DateTime.truncate(:second)
    }
  end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
