defmodule TechForGoodNearYou.MeetUpsTest do
  use TechForGoodNearYou.DataCase

  alias TechForGoodNearYou.MeetUps

  describe "events" do
    alias TechForGoodNearYou.MeetUps.Event

    @valid_attrs %{address: "some address", group_name: "some group_name", name: "some name", postcode: "sw99ng", url: "www.event.com", time: ~N[2010-04-17 14:00:00.000000], venue_name: "some venue_name"}
    @update_attrs %{address: "some updated address", group_name: "some updated group_name", name: "some updated name", postcode: "e20sy", url: "www.event.com", time: ~N[2011-05-18 15:01:01.000000], venue_name: "some updated venue_name"}
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
      assert event.postcode == "sw99ng"
      assert event.time == ~N[2010-04-17 14:00:00.000000]
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
      assert event.postcode == "e20sy"
      assert event.time == ~N[2011-05-18 15:01:01.000000]
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
