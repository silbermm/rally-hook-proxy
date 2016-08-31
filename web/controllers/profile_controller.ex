defmodule RallyHookProxy.ProfileController do
  use RallyHookProxy.Web, :controller

  alias RallyHookProxy.User
  alias RallyHookProxy.UnauthenticatedController

  plug Guardian.Plug.EnsureAuthenticated, handler: UnauthenticatedController

  def index(conn, params) do
    guser = Guardian.Plug.current_resource(conn)
    user = User.find_by_username(guser.email)
    render conn, changeset: User.changeset(user)
  end

  def update(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Your account has been successfully updated")
        |> render "index.html", changeset: user
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong updating your profile")
        |> render "index.html", changeset: changeset
    end
  end

end
