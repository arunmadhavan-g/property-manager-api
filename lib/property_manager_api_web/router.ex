defmodule PropertyManagerApiWeb.Router do
  use PropertyManagerApiWeb, :router

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

  scope "/", PropertyManagerApiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end


  scope "/api/v1", PropertyManagerApi do
    pipe_through :api
    get "/projects", ProjectController, :projects
    get "/projects/exists", ProjectController, :exists
    post "/projects", ProjectController, :create
    delete "/projects", ProjectController,  :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", PropertyManagerApiWeb do
  #   pipe_through :api
  # end
end
