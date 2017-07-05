defmodule TechForGoodNearYou.Web.EventController do
  use TechForGoodNearYou.Web, :controller

  alias TechForGoodNearYou.{MeetUps, Web.LatLon}

  def index(conn, _params) do
    approved_events = MeetUps.list_approved_events()
    events_waiting_approval = MeetUps.list_events_waiting_approval()
    render(
      conn,
      "index.html",
      approved_events: approved_events,
      events_waiting_approval: events_waiting_approval
    )
  end

  def new(conn, _params) do
    changeset = MeetUps.change_event(%TechForGoodNearYou.MeetUps.Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, _changeset} <- MeetUps.validate_postcode(event_params),
         {:ok, lat_lon} <- LatLon.get_lat_lon(event_params["postcode"]),
         event_params = Map.merge(event_params, lat_lon),
         event_params = Map.put_new(event_params, "approved", true),
         {:ok, event} <- MeetUps.create_event(event_params)
    do
      conn
      |> put_flash(:info, "Event created successfully.")
      |> redirect(to: event_path(conn, :show, event))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
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

    with {:ok, _changeset} <- MeetUps.validate_postcode(event_params),
         {:ok, lat_lon} <- LatLon.get_lat_lon(postcode),
         event_params = Map.merge(event_params, lat_lon),
         {:ok, event} <- MeetUps.update_event(event, event_params)
    do
      conn
      |> put_flash(:info, "Event updated successfully.")
      |> redirect(to: event_path(conn, :show, event))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
      {:error, _reason} ->
        conn
        |> put_flash(:error, "There was a problem updating the event, please try again")
        |> redirect(to: event_path(conn, :edit, event))
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

  def custom_events(conn, _params) do
    events = MeetUps.list_approved_events()
    render conn, "events.json", %{events: events}
  end

  def submit_event_new(conn, _params) do
    changeset = MeetUps.change_event(%TechForGoodNearYou.MeetUps.Event{})
    render(conn, "submit_event.html", changeset: changeset, action: event_path(conn, :submit_event_create))
  end

  def submit_event_create(conn, %{"event" => event_params}) do
    with {:ok, _changeset} <- MeetUps.validate_postcode(event_params),
         {:ok, lat_lon} <- LatLon.get_lat_lon(event_params["postcode"]),
         event_params = Map.merge(event_params, lat_lon),
         event_params = Map.put_new(event_params, "approved", false),
         {:ok, _event} <- MeetUps.create_event(event_params)
    do
      conn
      |> redirect(to: event_path(conn, :submit_event_confirmation))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "submit_event.html", changeset: changeset)
      {:error, _reason} ->
        conn
        |> put_flash(:error, "There was a problem adding the event, please try again")
        |> redirect(to: event_path(conn, :submit_event_new))
    end
  end

  def submit_event_confirmation(conn, _params) do
    render(conn, "confirmation.html")
  end

  def approve_event(conn, %{"id" => id}) do
    event = MeetUps.get_event!(id)

    case MeetUps.update_event(event, %{approved: true}) do
      {:ok, _event} ->
        conn
        |> put_flash(:info, "The event has been approved")
        |> redirect(to: event_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was a problem updating the event")
        |> redirect(to: event_path(conn, :index))
    end
  end
end
