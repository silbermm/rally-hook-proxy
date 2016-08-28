defmodule RallyHookProxy.SessionController do
  use RallyHookProxy.Web, :controller

  alias RallyHookProxy.User

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

  def login(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    user = Repo.get_by(User, email: String.downcase(user_params["email"]))
    authenticated? = Comeonin.Bcrypt.checkpw(user_params["password"], user.crypted_password)
    if authenticated? do
      conn
      |> Guardian.Plug.sign_in(user)
      |> put_flash(:info, "Your have been logged in successfully")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "There was a problem authenticating your account")
      |> render("index.html", changeset: changeset)
    end
  end
end
