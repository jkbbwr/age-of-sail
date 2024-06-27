defmodule Aos.Repo do
  use Ecto.Repo,
    otp_app: :aos,
    adapter: Ecto.Adapters.Postgres
end
