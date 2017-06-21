defmodule TechForGoodNearYou.Web.Router do
  use TechForGoodNearYou.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :put_layout, {TechForGoodNearYou.Web.LayoutView, :admin}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TechForGoodNearYou.Web do
    pipe_through :browser

    get "/", ElmController, :index
  end

  scope "/admin", TechForGoodNearYou.Web do
    pipe_through :browser
    pipe_through :admin

    resources "/events", EventController
  end

  scope "/api", TechForGoodNearYou.Web do
    pipe_through :api

    get "/meetup-events", MeetupController, :index
    get "/admin-events", ElmController, :events
  end
end
