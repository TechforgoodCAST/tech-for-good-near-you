defmodule TechForGoodNearYou.Web.Router do
  use TechForGoodNearYou.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TechForGoodNearYou.Web do
    pipe_through :browser

    get "/", ElmController, :index
    resources "/event", EventController
  end

  scope "/api", TechForGoodNearYou.Web do
    pipe_through :api

    get "/events", MeetupController, :index
  end
end
