defmodule AltstatusWeb.AdminController do
  use AltstatusWeb, :controller

  alias Altstatus.Accounts
  alias Altstatus.Accounts.Admin

  action_fallback AltstatusWeb.FallbackController

  def index(conn, _params) do
    admins = Accounts.list_admins()
    render(conn, "index.json", admins: admins)
  end

  def create(conn, admin_params) do
    with {:ok, %Admin{} = admin} <- Accounts.create_admin(admin_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", admin_path(conn, :show, admin))
      |> render("show.json", admin: admin)
    end
  end

  def show(conn, %{"id" => id}) do
    admin = Accounts.get_admin!(id)
    render(conn, "show.json", admin: admin)
  end

  def update(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Accounts.get_admin!(id)

    with {:ok, %Admin{} = admin} <- Accounts.update_admin(admin, admin_params) do
      render(conn, "show.json", admin: admin)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin = Accounts.get_admin!(id)
    with {:ok, %Admin{}} <- Accounts.delete_admin(admin) do
      send_resp(conn, :no_content, "")
    end
  end
end
