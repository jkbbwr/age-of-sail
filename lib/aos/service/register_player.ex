defmodule Aos.Service.RegisterPlayer do
  alias Aos.Repo.PlayerRepo

  def call(attrs) do
    PlayerRepo.create(attrs)
  end
end
