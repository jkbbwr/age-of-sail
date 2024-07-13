ExUnit.start(exclude: [:skip])
Faker.start()
Ecto.Adapters.SQL.Sandbox.mode(Aos.Repo, :manual)
