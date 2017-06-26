defmodule TechForGoodNearYou.Web.Router do
  use TechForGoodNearYou.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TechForGoodNearYou.Web.Auth
  end

  pipeline :admin_layout do
    plug :put_layout, {TechForGoodNearYou.Web.LayoutView, :admin}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TechForGoodNearYou.Web do
    pipe_through :browser

    get "/", ElmController, :index
  end

  scope "/login", TechForGoodNearYou.Web do
    pipe_through [:browser, :admin_layout]

    get "/", SessionController, :new
    resources "/", SessionController, only: [:new, :create, :delete]
  end

  scope "/admin", TechForGoodNearYou.Web do
    pipe_through [:browser, :admin_layout, :authenticate_admin]

    resources "/events", EventController
  end

  scope "/api", TechForGoodNearYou.Web do
    pipe_through :api

    get "/meetup-events", MeetupController, :index
    get "/custom-events", EventController, :custom_events
  end
end
