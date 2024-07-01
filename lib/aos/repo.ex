defmodule Aos.Repo do
  use Ecto.Repo,
    otp_app: :aos,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10, allow_overflow_page_number: true
end
