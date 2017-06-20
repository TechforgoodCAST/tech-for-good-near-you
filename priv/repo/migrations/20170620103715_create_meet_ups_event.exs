defmodule TechForGoodNearYou.Repo.Migrations.CreateTechForGoodNearYou.MeetUps.Event do
  use Ecto.Migration

  def change do
    create table(:meet_ups_events) do
      add :name, :string
      add :time, :utc_datetime
      add :address, :string
      add :postcode, :string
      add :venue_name, :string
      add :group_name, :string

      timestamps()
    end

  end
end
