defmodule TechForGoodNearYou.Web.ElmView do
  use TechForGoodNearYou.Web, :view
  alias TechForGoodNearYou.Web.EventView

  def render("events.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end
end
