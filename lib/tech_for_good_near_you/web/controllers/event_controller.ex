defmodule TechForGoodNearYou.Web.EventController do
  use TechForGoodNearYou.Web, :controller

  @group_ids [
    "1277423",
    "19866282",
    "18854399",
    "1302479",
    "16347132",
    "22407110",
    "12205442",
    "22082866",
    "2503312",
    "7975692",
    "19414181",
    "18542782",
    "1635343",
    "18436868",
    "19911171",
    "22216274",
    "18976100",
    "17833522",
    "18037392",
    "19201419",
    "22434994",
    "20399973",
    "22283959",
    "14592582",
    "11072312",
    "466780",
    "11972762",
    "20791546",
    "20232146",
    "18509845"
  ]

  def index(conn, _params) do
    response =
      HTTPoison.get!("https://api.meetup.com/2/events", [], params: [{"group_id", Enum.join(@group_ids, ",")}])
      |> Map.get(:body)
      |> Poison.decode!

    json(conn, response["results"])
  end
end
