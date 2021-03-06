defmodule RallyHookProxy.UserTest do
  use RallyHookProxy.ModelCase

  alias RallyHookProxy.User

  @valid_attrs %{password: "fdsaf", crypted_password: "some content", email: "some@content.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
