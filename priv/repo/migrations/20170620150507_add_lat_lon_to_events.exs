defmodule TechForGoodNearYou.Repo.Migrations.AddLatLonToEvents do
  use Ecto.Migration

  def change do
    alter table(:meet_ups_events) do
      add :latitude, :float
      add :longitude, :float
    end
  end
end
