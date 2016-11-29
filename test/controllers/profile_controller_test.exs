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

  test "should update rally_key", %{ user: user } do
    conn = guardian_login(user)
    user = %{ user | rally_token: "new_updated"}
    conn = conn |> put("/profile", %{ "user" => user })
    assert html_response(conn, 200) =~ "new_updated"
    assert conn.assigns.changeset.model.rally_token == "new_updated"
  end

end
