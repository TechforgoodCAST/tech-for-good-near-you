defmodule TechForGoodNearYou.MeetUps.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias TechForGoodNearYou.MeetUps.Event


  schema "meet_ups_events" do
    field :address, :string
    field :group_name, :string
    field :name, :string
    field :postcode, :string
    field :time, :utc_datetime
    field :venue_name, :string

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:name, :time, :address, :postcode, :venue_name, :group_name])
    |> validate_required([:name, :time, :address, :postcode, :venue_name, :group_name])
  end
end
