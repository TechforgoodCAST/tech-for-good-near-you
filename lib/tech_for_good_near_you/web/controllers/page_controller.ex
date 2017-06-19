defmodule TechForGoodNearYou.Web.PageController do
  use TechForGoodNearYou.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
