defmodule RallyHookProxy.PageController do
  use RallyHookProxy.Web, :controller

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    IO.inspect user
    render conn, "index.html"
  end
end
