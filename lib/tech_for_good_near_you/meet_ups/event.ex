defmodule TechForGoodNearYou.MeetUps.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias TechForGoodNearYou.MeetUps.Event


  schema "meet_ups_events" do
    field :name, :string
    field :url, :string
    field :time, :naive_datetime
    field :address, :string
    field :postcode, :string
    field :venue_name, :string
    field :group_name, :string
    field :latitude, :float
    field :longitude, :float

    timestamps()
  end

  @valid_fields [:name, :url, :time, :address, :postcode, :venue_name, :group_name, :latitude, :longitude]
  @required_fields [:name, :time, :address, :postcode, :url]

  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, @valid_fields)
    |> validate_required(@required_fields)
  end
end
