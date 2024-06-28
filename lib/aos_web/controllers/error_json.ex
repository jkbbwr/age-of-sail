defmodule AosWeb.ErrorJSON do
  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end

  def error(%{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  def invalid_password(_attrs) do
    %{message: "invalid password"}
  end

  def expired_token(_attrs) do
    %{message: "expired token"}
  end

  def invalid_auth(_attrs) do
    %{message: "invalid auth"}
  end

  def render("404.json", error) do
    %{message: error.reason.message}
  end

  def render("500.json", error) do
    %{message: error.reason.message}
  end
end
