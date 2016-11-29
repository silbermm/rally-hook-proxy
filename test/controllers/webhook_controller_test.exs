defmodule RallyHookProxy.WebHookControllerTest do
  use RallyHookProxy.ConnCase

  import RallyHookProxy.Factory

  setup do
    user_auth = create(:user)
    {:ok, %{user: user_auth}}
  end

  describe "list" do
    test "should not list webhooks because not rally token", %{ user: user } do
      conn = guardian_login(user)
        |> get("/profile/webhooks")
      assert html_response(conn, 302)
    end

    test "should list all webhooks from Rally", %{ user: user } do
      #user = %{ user | rally_token: "rally_token_with_response" }
      user = create(:user_with_good_token)
      conn = guardian_login(user)
        |> get("/profile/webhooks")
      assert html_response(conn, 200)
      assert Enum.count(conn.assigns.current_webhooks) > 1
    end

    test "should get an empty list if rally returns an error" do
      user = create(:user_with_error_token)
      conn = guardian_login(user)
        |> get("/profile/webhooks")
      assert html_response(conn, 200)
      assert Enum.count(conn.assigns.current_webhooks) == 0
    end
  end

end
