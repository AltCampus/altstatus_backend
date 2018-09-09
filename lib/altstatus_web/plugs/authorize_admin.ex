defmodule AltstatusWeb.Plugs.AuthorizeAdmin do
	import Plug.Conn
	import Phoenix.Controller

	 def init(_params) do
	    
	 end

  def call(conn, _params) do
  	if Enum.any?(get_req_header(conn, "token")) do
      [token | _] = get_req_header(conn, "token")
      case Phoenix.Token.verify(conn, "admin salt", token) do
        {:ok, _admin_id} -> 
          conn
        {:error, _} ->
          conn
          |> json(%{error: "unauthorized"})
      end
    else 
      conn
      |> json(%{error: "unauthorized"})
    end
  end
end