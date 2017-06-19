defmodule TechForGoodNearYou.Web.ElmController do
  use TechForGoodNearYou.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
