defmodule TechForGoodNearYou.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias TechForGoodNearYou.Accounts.Admin


  schema "accounts_admins" do
    field :password, :string
    field :username, :string
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
  end
end
