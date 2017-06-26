defmodule TechForGoodNearYou.Repo.Migrations.CreateTechForGoodNearYou.Accounts.Admin do
  use Ecto.Migration

  def change do
    create table(:accounts_admins) do
      add :username, :string
      add :password, :string
    end

  end
end
