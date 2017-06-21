defmodule TechForGoodNearYou.Web.ElmController do
  use TechForGoodNearYou.Web, :controller
  alias TechForGoodNearYou.MeetUps

  def index(conn, _params) do
    render conn, "index.html"
  end

  def events(conn, _params) do
    events = MeetUps.list_future_events()
    render conn, "events.json", %{events: events}
  end
end
