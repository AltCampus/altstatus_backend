defmodule AltstatusWeb.PageController do
  use AltstatusWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
