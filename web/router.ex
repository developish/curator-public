defmodule Curator.Router do
  use Curator.Web, :router

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

  scope "/", Curator do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/registrations", RegistrationController, only: [:new, :create]
    get "/signin", SessionController, :new
    post "/signin", SessionController, :create
    delete "/signout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Curator do
  #   pipe_through :api
  # end
end
