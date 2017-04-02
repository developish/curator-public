defmodule Curator.RegistrationController do
  use Curator.Web, :controller

  alias Curator.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"registration" => registration_params}) do
    changeset = User.changeset(%User{}, registration_params)

    case Repo.insert(changeset) do
      { :ok, _changeset } ->
        render conn, :thanks
      { :error, changeset } ->
        render conn, :new, changeset: changeset
    end
  end
end
