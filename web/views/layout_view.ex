defmodule RallyHookProxy.LayoutView do
  use RallyHookProxy.Web, :view
  alias RallyHookProxy.User

  def user_info(conn) do
    case Guardian.Plug.current_resource(conn) do
      %User{email: email} -> email
      _ -> nil
    end
  end

end
