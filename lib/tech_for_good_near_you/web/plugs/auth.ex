defmodule TechForGoodNearYou.Web.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias TechForGoodNearYou.Accounts
  alias TechForGoodNearYou.Accounts.Admin
  alias TechForGoodNearYou.Web.Router.Helpers

  def init(opts) do
    opts
  end

  def call(%{assigns: %{admin: %Admin{}}} = conn, _opts), do: conn

  def call(conn, _opts) do
    id = get_session(conn, :id)
    if admin = (id && Accounts.get_admin(id)) do
      assign(conn, :admin, admin)
    else
      assign(conn, :admin, nil)
    end
  end

  def login(conn, admin) do
    conn
    |> assign(:admin, admin)
    |> put_session(:id, admin.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_admin(conn, _opts) do
    if conn.assigns.admin do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Helpers.session_path(conn, :new))
    end
  end

  def login_by_username_and_pass(conn, username, given_pass) do
    admin = Accounts.get_admin_by(username: username)

    cond do
      admin && checkpw(given_pass, admin.password) ->
        {:ok, login(conn, admin)}
      admin ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
