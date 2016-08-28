defmodule RallyHookProxy.RegistrationControllerTest do
  use RallyHookProxy.ConnCase

  test "GET /registrations", %{conn: conn} do
    conn = get conn, "/registrations"
    assert html_response(conn, 200)
  end
end
