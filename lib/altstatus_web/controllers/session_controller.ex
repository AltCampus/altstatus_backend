defmodule AltstatusWeb.SessionController do
  use AltstatusWeb, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2]
  alias Altstatus.Accounts

  def user_login(conn, %{"email" => email, "password" => pass}) do


    user = Accounts.get_user_by_email(email)

    cond do
      user &&  checkpw(pass, user.password_hash) ->

        token = Phoenix.Token.sign(conn, "user salt", user.id)
        conn
        |> fetch_session
        |> put_session(:user_id, user.id)
        |> json(%{id: user.id, email: user.email, name: user.name, batch: user.batch.name, token: token})

      
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

  def current_user(conn, _params) do
    if Enum.any?(get_req_header(conn, "token")) do

      [token | _] = get_req_header(conn, "token")
      case Phoenix.Token.verify(conn, "user salt", token) do
        {:ok, user_id} ->  
          user = Accounts.get_user!(user_id)

          conn
          |> json(%{id: user.id, email: user.email, name: user.name, batch: user.batch.name})  
        {:error, _} ->  
          conn
          |> json(%{error: "unauthorized"})  
      end
    else 
      conn
      |> json(%{error: "unauthorized"})
    end
  end

  def admin_login(conn, %{"email" => email, "password" => pass}) do


    admin = Accounts.get_admin_by_email(email)

    cond do
      admin &&  checkpw(pass, admin.password_hash) ->

        token = Phoenix.Token.sign(conn, "admin salt", admin.id)
        conn
        |> fetch_session
        |> put_session(:admin_id, admin.id)
        |> json(%{id: admin.id, email: admin.email, token: token})

      
      admin ->
        conn
        |> put_flash(:error, "Incorrect password")
        |> json(%{error: "Incorrect Password"})

      true ->
        conn
        |> put_flash(:error, "Invalid Email/password Combination")
        |> json(%{error: "Invalid Email/password Combination"})
    end
  end

  def admin_logout(conn, _params) do
    conn
    |> fetch_session
    |> delete_session(:admin_id)
    |> json(%{info: "success"})
  end

  def current_admin(conn, _params) do
    if Enum.any?(get_req_header(conn, "token")) do

      [token | _] = get_req_header(conn, "token")
      case Phoenix.Token.verify(conn, "admin salt", token) do
        {:ok, admin_id} ->  
          admin = Accounts.get_admin!(admin_id)

          conn
          |> json(%{id: admin.id, email: admin.email})  
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

