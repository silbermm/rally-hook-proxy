defmodule RallyHookProxy.RallyKeyTest do
  use RallyHookProxy.ModelCase

  alias RallyHookProxy.RallyKey

  @valid_attrs %{rally_token: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RallyKey.changeset(%RallyKey{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RallyKey.changeset(%RallyKey{}, @invalid_attrs)
    refute changeset.valid?
  end
end
