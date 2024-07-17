defmodule Aos.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:player) do
      add :email, :text, null: false
      add :name, :text, null: false
      add :password_hash, :text, null: false
      timestamps()
    end

    create unique_index(:player, :email)
    create unique_index(:player, :name)

    create table(:company) do
      add :ticker, :text, null: false
      add :name, :text, null: false
      add :treasury, :integer, null: false
      add :player_id, references(:player), null: false
      timestamps()
    end

    create constraint(:company, :treasury,
             check: "treasury >= 0",
             comment: "ensure treasury can never drop under 0"
           )

    create unique_index(:company, :ticker)
    create unique_index(:company, :player_id)

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

    create unique_index(:item, :shortcode)

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
      add :speed, :integer, null: false
      add :company_id, references(:company)
      add :port_id, references(:port)
      timestamps()
    end

    create table(:route) do
      add :source_id, references(:port), null: false
      add :destination_id, references(:port), null: false

      add :length, :integer,
        null: false,
        comment: "the number of days it takes to sail this route before modifiers"

      add :description, :text, null: false
      timestamps()
    end

    create table(:transit) do
      add :ship_id, references(:ship)
      add :route_id, references(:route)
      add :step, :integer
    end

    create table(:trader) do
      add :port_id, references(:port), null: false
      add :name, :text, null: false
      timestamps()
    end

    create table(:trader_plan) do
      add :trader_id, references(:trader), null: false
      add :item_id, references(:item), null: false

      add :desired_stock, :integer,
        null: false,
        comment: "how much stock the trader wants to have"

      add :price_elasticity, :float,
        null: false,
        comment: "how sensitive the price is to the change in stock"

      add :price_volatility, :float,
        null: false,
        comment: "controls the randomness of price adjustments"

      add :stock_volatility, :float,
        null: false,
        comment: "controls the randomness of stock adjustments"

      add :replenishment_rate, :integer,
        null: false,
        comment: "the rate at which stock is replenished"

      timestamps()
    end

    create unique_index(:trader_plan, [:trader_id, :item_id],
             comment: "there can only be a single plan per item per trader"
           )

    create table(:trader_inventory) do
      add :trader_id, references(:trader), null: false
      add :item_id, references(:item), null: false
      add :stock, :integer, null: false
      add :cost, :integer, null: false
      timestamps()
    end

    create unique_index(:trader_inventory, [:trader_id, :item_id],
             comment: "traders stock only one instance of each item"
           )

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
      add :cost, :integer, null: false
      timestamps()
    end

    create table(:warehouse) do
      add :port_id, references(:port), null: false
      add :capacity, :integer, null: false
      add :company_id, references(:company), null: false
      timestamps()
    end

    create table(:warehouse_inventory) do
      add :item_id, references(:item), null: false
      add :quantity, :integer, null: false
      add :warehouse_id, references(:warehouse), null: false
      timestamps()
    end

    create table(:ship_inventory) do
      add :ship_id, references(:ship)
    end

    create table(:company_agent) do
      add :company_id, references(:company), null: false
      add :port_id, references(:port), null: false
      timestamps()
    end

    create unique_index(:company_agent, [:company_id, :port_id],
             comment: "companies can only have one agent in each port"
           )

    create unique_index(:warehouse, [:company_id, :port_id],
             comment: "companies can only have one warehouse in each port"
           )
  end
end
