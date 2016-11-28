defmodule RallyHookProxy.ProfileControllerTest do
  use RallyHookProxy.ConnCase

  import RallyHookProxy.Factory

  setup do
    user_auth = create(:user) |> with_rally_key
    {:ok, %{user: user_auth}}
  end

  test "load profile page for logged in user", %{ user: user } do
    conn = guardian_login(user)
      |> get("/profile")
    assert html_response(conn, 200)
  end

  test "do not load profile page for non-logged in users", %{ conn: conn } do
    conn = get conn, "/profile"
    assert html_response(conn, 302)
  end

end
