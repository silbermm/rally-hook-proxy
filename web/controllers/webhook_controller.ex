defmodule RallyHookProxy.WebHookController do
  use RallyHookProxy.Web, :controller

  alias RallyHookProxy.User
  alias RallyHookProxy.UnauthenticatedController

  plug Guardian.Plug.EnsureAuthenticated, handler: UnauthenticatedController

  @webhooks Application.get_env(:rally_hook_proxy, :rally_webhooks)

  def index(conn, params) do
    # does the current user have a rally key configured?
    guser = Guardian.Plug.current_resource(conn)
    if (guser.rally_token == nil) do
      conn
      |> put_flash(:info, "You must first configure your Rally Api Key")
      |> redirect(to: "/profile")
    else
      webhooks = case @webhooks.list(guser.rally_token) do
        {:ok, %{"Results" => response}} -> response
        {:error, err} -> []
      end
      webhooks = Enum.map(webhooks, &(Map.from_struct(&1)))
      conn
      |> render("index.html", current_webhooks: webhooks)
    end
  end


  def handler(conn, _params) do
    #figure out what webhook was called... by look at the _ref

    #call configured endpoint
  end
end
