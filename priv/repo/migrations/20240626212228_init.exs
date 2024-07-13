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
      add :arriving_at, :timestamptz
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

    create table(:trader) do
      add :port_id, references(:port), null: false
      add :name, :text, null: false
      timestamps()
    end

    create table(:trader_plan) do
      add :trader_id, references(:trader), null: false
      add :item_id, references(:item), null: false
      add :peak, :integer, null: false, comment: "maximum production at the peak of the curve"
      add :max, :integer, null: false, comment: "maximum production for this item at this trader"
      add :fluctuation, :float, null: false, comment: "random fluctuation to model volatility"
      add :mean, :float, null: false, comment: "mean for the gaussian distribution"
      add :std_dev, :float, null: false, comment: "standard deviation for gaussian distribution"

      add :sensitivity, :float,
        null: false,
        comment: "sensitivity of price to stock level changes"
    end

    create constraint(:trader_plan, :peak_must_be_greater_than_zero, check: "peak > 0")
    create constraint(:trader_plan, :max_must_be_greater_than_zero, check: "max > 0")

    create constraint(:trader_plan, :sensitivity_must_be_greater_than_zero,
             check: "sensitivity > 0"
           )

    create constraint(:trader_plan, :mean_inside_bounds, check: "mean >= 0.0 and mean <= 1.0")

    create constraint(:trader_plan, :std_dev_inside_bounds,
             check: "std_dev >= 0.0 and std_dev <= 1.0"
           )

    create constraint(:trader_plan, :fluctuation_inside_bounds,
             check: "fluctuation >= 0.0 and fluctuation <= 1.0"
           )

    create unique_index(:trader_plan, [:trader_id, :item_id],
             comment: "there can only be a single plan per item per trader"
           )

    create table(:trader_inventory) do
      add :trader_id, references(:trader), null: false
      add :item_id, references(:item), null: false
      add :quantity, :integer, null: false
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
