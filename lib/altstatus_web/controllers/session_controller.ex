defmodule AltstatusWeb.SessionController do
  use AltstatusWeb, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias Altstatus.Accounts

  def user_login(conn, %{"email" => email, "password" => pass}) do


    user = Accounts.get_user_by_email(email)

    cond do
      user &&  checkpw(pass, user.password_hash) ->
        conn
        |> fetch_session
        |> put_session(:user_id, user.id)
        |> json(%{id: user.id, email: user.email, name: user.name})

      
      user ->
        conn
        |> put_flash(:error, "Incorrect password")
        |> json(%{error: "Incorrect Password"})

      true ->
        conn
        |> put_flash(:error, "Invalid Email/password Combination")
        |> json(%{error: "Invalid Email/password Combination"})
    end
  end

  def user_logout(conn, _params) do
    conn
    |> fetch_session
    |> delete_session(:user_id)
    |> json(%{info: "success"})
  end


end

