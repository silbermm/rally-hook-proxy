defmodule RallyHookProxy.Router do
  use RallyHookProxy.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/falcons", RallyHookProxy do
    pipe_through [:api]

    post "/accepted", WebHookController, :handler
  end


  scope "/", RallyHookProxy do
    pipe_through [:browser, :browser_auth]

    resources "/registrations", RegistrationController, only: [:new, :create]

    get  "/logout", SessionController, :logout
    get  "/login", SessionController, :index
    post "/login", SessionController, :login

    get "/profile", ProfileController, :index
    put "/profile", ProfileController, :update

    get "/profile/webhooks", WebHookController, :index
    
    get "/", PageController, :index
  end

    # Other scopes may use custom stacks.
  # scope "/api", RallyHookProxy do
  #   pipe_through :api
  # end
end
