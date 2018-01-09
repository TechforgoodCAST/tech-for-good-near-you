defmodule TechForGoodNearYou.Web.MeetupController do
  use TechForGoodNearYou.Web, :controller

  def index(conn, _params) do
    group_ids = Application.get_env(
      :tech_for_good_near_you,
      :meetup_group_ids
    )

    response =
      HTTPoison.get!(
        "https://api.meetup.com/2/events", [],
        params: [{"group_id", Enum.join(group_ids, ",")}]
      )
      |> Map.get(:body)
      |> Poison.decode!

    json(conn, response["results"])
  end
end
