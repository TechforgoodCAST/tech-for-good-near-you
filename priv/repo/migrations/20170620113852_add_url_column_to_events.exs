defmodule TechForGoodNearYou.Repo.Migrations.AddUrlColumnToEvents do
  use Ecto.Migration

  def change do
    alter table(:meet_ups_events) do
      add :url, :string, null: false
    end

  end
end
