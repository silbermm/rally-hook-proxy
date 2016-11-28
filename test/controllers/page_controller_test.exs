defmodule RallyHookProxy.PageControllerTest do
  use RallyHookProxy.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Rally Webhook Proxy"
  end
end
