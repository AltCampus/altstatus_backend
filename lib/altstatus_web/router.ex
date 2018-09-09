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
    plug :accepts, ["json"]

  end

  pipeline :user do
    plug AltstatusWeb.Plugs.AuthorizeUser
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
    # get "/submissions/user/:user_id", SubmissionController, :filter_submission
    get "/current_user", SessionController, :current_user

    resources "/batches", BatchController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    resources "/submissions", SubmissionController, except: [:new, :edit]

    scope "/" do
      pipe_through :user

      get "/submissions/user/:user_id", SubmissionController, :filter_submission
    end
  end


  # Other scopes may use custom stacks.
  # scope "/api", AltstatusWeb do
  #   pipe_through :api
  # end
end
