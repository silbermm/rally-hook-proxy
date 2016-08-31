defmodule RallyHookProxy.UnauthenticatedController do
  use RallyHookProxy.Web, :controller

  def unauthenticated(conn, params) do
   conn
   |> put_flash(:error, "Authentication Required")
   |> redirect(to: "/")
  end

end
