defmodule TechForGoodNearYou.Repo.Migrations.CreateTechForGoodNearYou.MeetUps.Event do
  use Ecto.Migration

  def change do
    create table(:meet_ups_events) do
      add :name, :string, null: false
      add :time, :utc_datetime, null: false
      add :address, :string, null: false
      add :postcode, :string, null: false
      add :venue_name, :string
      add :group_name, :string

      timestamps()
    end

  end
end
