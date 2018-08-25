defmodule FawkesWeb.Router do
  use FawkesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :guardian do
    plug FawkesWeb.Guardian.Plug
    plug FawkesWeb.Guardian.CurrentUserPlug
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FawkesWeb, as: :auth do
    pipe_through [:browser, :guardian, :ensure_auth]
    post("/logout", Auth.UserController, :delete)
  end

  scope "/", FawkesWeb, as: :membership do
    pipe_through [:browser, :guardian, :ensure_auth]

    resources("/profile", ProfileController, only: [:edit, :update], singleton: true)
  end


  scope "/", FawkesWeb do
    pipe_through [:browser, :guardian]

    get "/", PageController, :index

    resources("/schedule", ScheduleController, only: [:index, :show])
    resources("/audience", AudienceController, only: [:show])
    resources("/category", CategoryController, only: [:show])
    resources("/location", LocationController, only: [:show])
    resources("/speaker", SpeakerController, only: [:index, :show])
    resources("/talk", TalkController, only: [:show])
    resources("/member", ProfileController, only: [:index, :show])
  end

  scope "/signup", FawkesWeb.Signup, as: :signup do
    pipe_through [:browser, :guardian]

    resources "/", UserController, only: [:new, :create]
  end

  scope "/login", FawkesWeb.Auth, as: :auth do
    pipe_through [:browser, :guardian]

    resources "/", UserController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FawkesWeb do
  #   pipe_through :api
  # end
end
