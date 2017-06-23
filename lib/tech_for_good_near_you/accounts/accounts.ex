defmodule TechForGoodNearYou.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.Query, warn: false
  alias TechForGoodNearYou.Repo

  alias TechForGoodNearYou.Accounts.Admin

  def get_admin(id), do: Repo.get(Admin, id)
  def get_admin_by(opts), do: Repo.get_by(Admin, opts)
end
