defmodule RandomPickWeb.Router do
  use RandomPickWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RandomPickWeb do
    pipe_through :api

    post "/create_user", UserController, :create
    post "/create_lottery", LotteryController, :create
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RandomPickWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
