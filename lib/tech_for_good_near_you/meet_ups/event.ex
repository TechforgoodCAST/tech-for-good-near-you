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
    field :approved, :boolean

    timestamps()
  end

  @valid_fields [:name,
                 :url,
                 :time,
                 :address,
                 :postcode,
                 :venue_name,
                 :group_name,
                 :latitude,
                 :longitude,
                 :approved]

  @required_fields [:name,
                    :time,
                    :address,
                    :postcode,
                    :url,
                    :approved]

  @valid_postcode_regex ~r/(GIR 0AA)|([A-PR-UWYZ](([0-9]([0-9A-HJKPSTUW])?)|([A-HK-Y][0-9]([0-9ABEHMNPRVWXY])?))\s?[0-9][ABD-HJLNP-UW-Z]{2})/i

  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, @valid_fields)
    |> validate_required(@required_fields)
    |> validate_format(:postcode, @valid_postcode_regex)
  end

  def validate_postcode_changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:postcode])
    |> validate_format(:postcode, @valid_postcode_regex)
  end
end
