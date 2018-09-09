defmodule AltstatusWeb.Router do
  use AltstatusWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]

  end

  pipeline :user do
    plug AltstatusWeb.Plugs.AuthorizeUser
  end

  pipeline :admin do
    plug AltstatusWeb.Plugs.AuthorizeAdmin
  end

  scope "/", AltstatusWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  scope "/api", AltstatusWeb do
    pipe_through :api

    post "/users/register", UserController, :create
    post "/users/login", SessionController, :user_login
    post "/users/logout", SessionController, :user_logout
    post "/admin/register", AdminController, :create
    post "/admin/login", SessionController, :admin_login
    post "/admin/logout", SessionController, :admin_logout
    resources "/admins", AdminController, except: [:new, :edit]
    # get "/submissions/user/:user_id", SubmissionController, :filter_submission
    get "/current_user", SessionController, :current_user
    get "/current_admin", SessionController, :current_admin
    get "/batches", BatchController, :index

    
    # resources "/users", UserController, except: [:new, :edit]
    # resources "/submissions", SubmissionController, except: [:new, :edit]

    scope "/" do
      pipe_through :user

      get "/submissions/user/:user_id", SubmissionController, :filter_submission
      post "/submissions", SubmissionController, :create
    end

    scope "/admin" do
      pipe_through :admin

      resources "/batches", BatchController, except: [:new, :edit]
      resources "/users", UserController, except: [:new, :edit]
      resources "/submissions", SubmissionController, except: [:new, :edit]
    end
  end


  # Other scopes may use custom stacks.
  # scope "/api", AltstatusWeb do
  #   pipe_through :api
  # end
end
