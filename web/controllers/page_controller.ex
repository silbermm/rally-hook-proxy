defmodule RallyHookProxy.PageController do
  use RallyHookProxy.Web, :controller
  require IEx

  def index(conn, _params) do
    IEx.pry
    user = Guardian.Plug.current_resource(conn)
    render conn, "index.html"
  end
end
