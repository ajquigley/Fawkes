defmodule FawkesWeb.Router do
  use FawkesWeb, :router

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

  scope "/", FawkesWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources("/schedule", ScheduleController, only: [:index, :show])
    resources("/audience", AudienceController, only: [:show])
    resources("/category", CategoryController, only: [:show])
    resources("/location", LocationController, only: [:show])
    resources("/speaker", SpeakerController, only: [:index, :show])
    resources("/talk", TalkController, only: [:show])
  end

  scope "/signup", FawkesWeb.Signup, as: :signup do
    pipe_through :browser

    resources "/", UserController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FawkesWeb do
  #   pipe_through :api
  # end
end
