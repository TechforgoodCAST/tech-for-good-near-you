defmodule TechForGoodNearYou.Web.EventView do
  use TechForGoodNearYou.Web, :view
  alias TechForGoodNearYou.Web.EventView

  def render("events.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{name: event.name,
      url: event.url,
      time: event.time,
      address: event.address,
      latitude: event.latitude,
      longitude: event.longitude,
      group_name: event.group_name,
      venue_name: event.venue_name}
  end
end
