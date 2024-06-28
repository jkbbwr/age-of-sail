defmodule Aos.Schema.AuthToken do
  use Aos.Schema

  schema "auth_token" do
    field :token, :string
    field :expires_at, :utc_datetime
    belongs_to :player, Aos.Schema.Player
    timestamps()
  end
end
