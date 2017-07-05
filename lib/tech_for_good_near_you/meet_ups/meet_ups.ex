defmodule TechForGoodNearYou.MeetUps do
  @moduledoc """
  The boundary for the MeetUps system.
  """

  import Ecto.Query, warn: false
  alias TechForGoodNearYou.Repo

  alias TechForGoodNearYou.MeetUps.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Returns the list of future events.

  ## Examples

      iex> list_future_events()
      [%Event{}, ...]

  """

  def list_approved_events do
    query = from e in Event,
              where: e.time > from_now(0, "second"),
              where: e.approved == true

    Repo.all(query)
  end

  def list_events_waiting_approval do
    query = from e in Event,
              where: e.time > from_now(0, "second"),
              where: e.approved == false

    Repo.all(query)
  end


  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  def validate_postcode(params) do
    change =
      %Event{}
      |> Event.validate_postcode_changeset(params)
      |> update_changeset_action(:validate_postcode)

    case change do
      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, changeset}
      changeset ->
        {:error, changeset}
    end
  end

  defp update_changeset_action(changeset, action) do
    %{changeset | action: action}
  end
end
