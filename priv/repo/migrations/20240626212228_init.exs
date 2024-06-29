defmodule Aos.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:player) do
      add :email, :text, null: false
      add :password_hash, :text, null: false
      timestamps()
    end

    create unique_index(:player, :email)

    create table(:company) do
      add :ticker, :text, null: false
      add :name, :text, null: false
      add :player_id, references(:player), null: false
      timestamps()
    end

    create unique_index(:company, :ticker)

    create table(:auth_token) do
      add :token, :text, null: false
      add :player_id, references(:player), null: false
      add :expires_at, :timestamptz, null: false
      timestamps()
    end

    create unique_index(:auth_token, :token)

    create table(:item) do
      add :shortcode, :text, null: false
      add :name, :text, null: false
      add :description, :text, null: false
      timestamps()
    end

    create table(:port) do
      add :shortcode, :text, null: false
      add :name, :text, null: false
      timestamps()
    end

    create unique_index(:port, :shortcode)
    create unique_index(:port, :name)

    create table(:ship) do
      add :name, :text, null: false
      add :type, :text, null: false
      add :cargo_space, :integer, null: false
      add :state, :text, null: false
      add :owner_id, references(:company)
      add :port_id, references(:port)
      add :arriving_at, :timestamptz
      timestamps()
    end

    create table(:route) do
      add :source_id, references(:port), null: false
      add :destination_id, references(:port), null: false

      add :length, :integer,
        null: false,
        comment: "The default time it takes to sail this route using the default ship"

      add :description, :text, null: false
      timestamps()
    end

    create table(:trader) do
      add :port_id, references(:port), null: false
      add :name, :text, null: false
      timestamps()
    end

    create table(:trader_inventory) do
      add :trader_id, references(:trader), null: false
      add :item_id, references(:item), null: false
      add :quantity, :integer, null: false
      add :cost, :integer, null: false
      timestamps()
    end

    create table(:orderbook) do
      add :port_id, references(:port), null: false
      add :company_id, references(:company), null: false
      add :item_id, references(:item), null: false
      add :order, :text, null: false
      add :amount, :integer, null: false
      add :cost, :integer, null: false
      timestamps()
    end

    create table(:shipyard) do
      add :port_id, references(:port), null: false
      timestamps()
    end

    create table(:shipyard_stock) do
      add :shipyard_id, references(:shipyard), null: false
      add :ship_id, references(:ship), null: false
    end

    create table(:warehouse) do
      add :port_id, references(:port), null: false
      add :capacity, :integer, null: false
      timestamps()
    end

    create table(:warehouse_entry) do
      add :item_id, references(:item), null: false
      add :quantity, :integer, null: false
      add :warehouse_id, references(:warehouse), null: false
      timestamps()
    end

    create table(:company_agent) do
      add :company_id, references(:company), null: false
      add :port_id, references(:port), null: false
      timestamps()
    end

    create unique_index(:company_agent, [:company_id, :port_id],
             comment: "companies can only have one agent in each port"
           )
  end
end
