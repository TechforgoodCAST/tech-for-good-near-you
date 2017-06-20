defmodule TechForGoodNearYou.Web.EventControllerTest do
  use TechForGoodNearYou.Web.ConnCase

  alias TechForGoodNearYou.MeetUps

  @create_attrs %{address: "some address", group_name: "some group_name", name: "some name", postcode: "some postcode", time: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, venue_name: "some venue_name"}
  @update_attrs %{address: "some updated address", group_name: "some updated group_name", name: "some updated name", postcode: "some updated postcode", time: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, venue_name: "some updated venue_name"}
  @invalid_attrs %{address: nil, group_name: nil, name: nil, postcode: nil, time: nil, venue_name: nil}

  def fixture(:event) do
    {:ok, event} = MeetUps.create_event(@create_attrs)
    event
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, event_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Events"
  end

  test "renders form for new events", %{conn: conn} do
    conn = get conn, event_path(conn, :new)
    assert html_response(conn, 200) =~ "New Event"
  end

  test "creates event and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == event_path(conn, :show, id)

    conn = get conn, event_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Event"
  end

  test "does not create event and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @invalid_attrs
    assert html_response(conn, 200) =~ "New Event"
  end

  test "renders form for editing chosen event", %{conn: conn} do
    event = fixture(:event)
    conn = get conn, event_path(conn, :edit, event)
    assert html_response(conn, 200) =~ "Edit Event"
  end

  test "updates chosen event and redirects when data is valid", %{conn: conn} do
    event = fixture(:event)
    conn = put conn, event_path(conn, :update, event), event: @update_attrs
    assert redirected_to(conn) == event_path(conn, :show, event)

    conn = get conn, event_path(conn, :show, event)
    assert html_response(conn, 200) =~ "some updated address"
  end

  test "does not update chosen event and renders errors when data is invalid", %{conn: conn} do
    event = fixture(:event)
    conn = put conn, event_path(conn, :update, event), event: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Event"
  end

  test "deletes chosen event", %{conn: conn} do
    event = fixture(:event)
    conn = delete conn, event_path(conn, :delete, event)
    assert redirected_to(conn) == event_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, event_path(conn, :show, event)
    end
  end
end
