defmodule TechForGoodNearYou.Repo do
  use Ecto.Repo, otp_app: :tech_for_good_near_you

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
