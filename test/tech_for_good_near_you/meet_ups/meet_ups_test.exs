defmodule TechForGoodNearYou.MeetUpsTest do
  use TechForGoodNearYou.DataCase

  alias TechForGoodNearYou.MeetUps

  describe "events" do
    alias TechForGoodNearYou.MeetUps.Event

    @valid_attrs %{address: "some address", group_name: "some group_name", name: "some name", postcode: "some postcode", time: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, venue_name: "some venue_name"}
    @update_attrs %{address: "some updated address", group_name: "some updated group_name", name: "some updated name", postcode: "some updated postcode", time: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, venue_name: "some updated venue_name"}
    @invalid_attrs %{address: nil, group_name: nil, name: nil, postcode: nil, time: nil, venue_name: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MeetUps.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert MeetUps.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert MeetUps.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = MeetUps.create_event(@valid_attrs)
      assert event.address == "some address"
      assert event.group_name == "some group_name"
      assert event.name == "some name"
      assert event.postcode == "some postcode"
      assert event.time == %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}
      assert event.venue_name == "some venue_name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MeetUps.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = MeetUps.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.address == "some updated address"
      assert event.group_name == "some updated group_name"
      assert event.name == "some updated name"
      assert event.postcode == "some updated postcode"
      assert event.time == %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}
      assert event.venue_name == "some updated venue_name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = MeetUps.update_event(event, @invalid_attrs)
      assert event == MeetUps.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = MeetUps.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> MeetUps.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = MeetUps.change_event(event)
    end
  end
end
