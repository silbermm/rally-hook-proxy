defmodule RallyHookProxy.RegistrationControllerTest do
  use RallyHookProxy.ConnCase

  test "GET /registrations", %{conn: conn} do
    conn = get conn, "/registrations/new"
    assert html_response(conn, 200)
  end

  test "successful registration", %{conn: conn} do
    conn = post conn, "/registrations", [user: %{:email => "john@mail.com", :password => "doe45678"}]
    assert get_flash(conn, :info) =~ "account was created"
    assert html_response(conn, 302)
    assert redirected_to(conn, 302) =~ "/"
  end

  test "bad email when registering", %{conn: conn} do
    conn = post conn, "/registrations", [user: %{:email => "john", :password => "doe45678"}]
    assert get_flash(conn, :error)
    assert html_response(conn, 200) =~ "<p>Oops, something went wrong! Please check the errors below:</p>"
  end
end
