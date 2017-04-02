defmodule Curator.UserTest do
  use Curator.ModelCase

  alias Curator.User

  @valid_attrs %{email: "user@example.com", password: "some content including spaces"}
  @invalid_attrs %{email: "noatsign", password: "short"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    assert changeset.errors[:email]
    assert changeset.errors[:password]
  end
end
