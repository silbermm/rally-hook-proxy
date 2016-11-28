defmodule RallyHookProxy.ProfileController do
  use RallyHookProxy.Web, :controller

  alias RallyHookProxy.User
  alias RallyHookProxy.UnauthenticatedController

  plug Guardian.Plug.EnsureAuthenticated, handler: UnauthenticatedController

  def index(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    render conn, changeset: User.changeset(user)
  end

  def update(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)
    user = %User{ user | rally_token: user_params["rally_token"] }
    case Repo.update(user) do
      {:ok, user} ->
        user = User.changeset(user)
        conn
        |> put_flash(:info, "Your account has been successfully updated")
        |> render "index.html", changeset: user
      {:error, changeset} ->
        changeset = User.changeset(changeset)
        conn
        |> put_flash(:error, "Something went wrong updating your profile")
        |> render "index.html", changeset: changeset
    end
  end

end
