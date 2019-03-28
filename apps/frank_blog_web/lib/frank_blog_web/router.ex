defmodule FrankBlogWeb.Router do
  use FrankBlogWeb, :router

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

  scope "/", FrankBlogWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/articles/new", PageController, :new
    post "/articles", PageController, :create
    resources "/account", UserController, only: [:index, :create, :new]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FrankBlogWeb do
  #   pipe_through :api
  # end
end
