defmodule Aos.Error do
  defmacro __using__(opts) do
    status = Keyword.get(opts, :status)
    message = Keyword.get(opts, :message)

    quote do
      defexception [:status, :message, :context]

      def new(context) do
        %__MODULE__{status: unquote(status), message: unquote(message), context: context}
      end
    end
  end
end

defmodule Aos.Error.ShipAtSea do
  use Aos.Error,
    status: 409,
    message: "ship is already underway"
end

defmodule Aos.Error.CompanyAlreadyHasAgent do
  use Aos.Error,
    status: 400,
    message: "Company already has an agent in this port"
end

defmodule Aos.Error.ShipNotOwnedByCompany do
  use Aos.Error,
    status: 403,
    message: "ship is not owned by company"
end

defmodule Aos.Error.CompanyNotOwnedByPlayer do
  use Aos.Error,
    status: 403,
    message: "company not owned by player"
end

defmodule Aos.Error.AgentNotEmployedByCompany do
  use Aos.Error,
    status: 403,
    message: "agent is not owned by player"
end
