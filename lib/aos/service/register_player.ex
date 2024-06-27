defmodule Aos.Service.RegisterPlayer do
  alias Aos.Repo.PlayerRepo

  def call(payload) do
    PlayerRepo.create(payload)
  end
end
