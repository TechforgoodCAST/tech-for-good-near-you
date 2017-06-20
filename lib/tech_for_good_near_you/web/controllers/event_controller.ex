defmodule TechForGoodNearYou.Web.EventController do
  use TechForGoodNearYou.Web, :controller

  alias TechForGoodNearYou.{MeetUps, LatLon}

  def index(conn, _params) do
    events = MeetUps.list_events()
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = MeetUps.change_event(%TechForGoodNearYou.MeetUps.Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => %{"postcode" => postcode} = event_params}) do
    case LatLon.get_lat_lon(postcode) do
      {:ok, lat_lon} ->
        event_params = Map.merge(event_params, lat_lon)
        case MeetUps.create_event(event_params) do
          {:ok, event} ->
            conn
            |> put_flash(:info, "Event created successfully.")
            |> redirect(to: event_path(conn, :show, event))
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
      {:error, _reason} ->
        conn
        |> put_flash(:error, "There was a problem adding the event, please try again")
        |> redirect(to: event_path(conn, :new))
    end
  end

  def show(conn, %{"id" => id}) do
    event = MeetUps.get_event!(id)
    render(conn, "show.html", event: event)
  end

  def edit(conn, %{"id" => id}) do
    event = MeetUps.get_event!(id)
    changeset = MeetUps.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => %{"postcode" => postcode} = event_params}) do
    event = MeetUps.get_event!(id)
    case LatLon.get_lat_lon(postcode) do
      {:ok, lat_lon} ->
        event_params = Map.merge(event_params, lat_lon)
        case MeetUps.update_event(event, event_params) do
          {:ok, event} ->
            conn
            |> put_flash(:info, "Event updated successfully.")
            |> redirect(to: event_path(conn, :show, event))
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", event: event, changeset: changeset)
        end
      {:error, _reason} ->
        conn
        |> put_flash(:error, "There was a problem updating the event, please try again")
        |> redirect(to: event_path(conn, :new))
    end
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = MeetUps.get_event!(id)

    case MeetUps.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: event_path(conn, :show, event))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = MeetUps.get_event!(id)
    {:ok, _event} = MeetUps.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: event_path(conn, :index))
  end
end
