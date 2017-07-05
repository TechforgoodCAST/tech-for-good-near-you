defmodule TechForGoodNearYou.Repo.Migrations.AddApprovedColumnToEvents do
  use Ecto.Migration

  def change do
    alter table(:meet_ups_events) do
      add :approved, :boolean, default: false
    end
  end
end
