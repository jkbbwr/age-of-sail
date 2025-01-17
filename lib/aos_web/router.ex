defmodule AosWeb.Router do
  use AosWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated_api do
    plug :accepts, ["json"]
    plug AosWeb.Auth
  end

  scope "/api", AosWeb do
    pipe_through :api

    post "/player/register", PlayerController, :register
    post "/player/login", AuthController, :login

    get "/company/list", CompanyController, :list
  end

  scope "/api", AosWeb do
    pipe_through :authenticated_api

    get "/player/me", PlayerController, :me

    get "/shipyard", ShipyardController, :all
    get "/shipyard/:shipyard_id", ShipyardController, :get
    post "/shipyard/:shipyard_id/buy", ShipyardController, :buy

    post "/warehouse/buy", WarehouseController, :buy
    post "/warehouse/capacity", WarehouseController, :modify

    post "/company/register", CompanyController, :register

    post "/agent/hire", CompanyAgentController, :hire

    get "/event", EventWebsocketUpgrade, AosWeb.EventWebsocket
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:aos, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AosWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
