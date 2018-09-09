defmodule AltstatusWeb.Plugs.AuthorizeUser do
	import Plug.Conn
	import Phoenix.Controller

	 def init(_params) do
	    
	 end

  def call(conn, _params) do
    IO.inspect conn
  	if Enum.any?(get_req_header(conn, "authorization")) do
      [token | _] = get_req_header(conn, "authorization")
      case Phoenix.Token.verify(conn, "user salt", token) do
        {:ok, _user_id} -> 
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