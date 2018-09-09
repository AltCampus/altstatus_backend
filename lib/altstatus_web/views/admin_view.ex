defmodule AltstatusWeb.AdminView do
  use AltstatusWeb, :view
  alias AltstatusWeb.AdminView

  def render("index.json", %{admins: admins}) do
    %{data: render_many(admins, AdminView, "admin.json")}
  end

  def render("show.json", %{admin: admin}) do
    %{data: render_one(admin, AdminView, "admin.json")}
  end

  def render("admin.json", %{admin: admin}) do
    %{id: admin.id,
      email: admin.email,
      password_hash: admin.password_hash}
  end
end
