defmodule TechForGoodNearYou.TestHelpers do
  alias TechForGoodNearYou.Repo
  alias TechForGoodNearYou.Accounts.Admin

  def insert_admin() do
    %Admin{}
    |> Admin.changeset(%{username: "ivan", password: "secret"})
    |> Repo.insert!()
  end
end
