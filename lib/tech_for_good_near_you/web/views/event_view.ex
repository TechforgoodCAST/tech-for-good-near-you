defmodule TechForGoodNearYou.Web.EventView do
  use TechForGoodNearYou.Web, :view

  def render("event.json", %{event: event}) do
    %{name: event.name, url: event.url, time: event.time}
  end
end
