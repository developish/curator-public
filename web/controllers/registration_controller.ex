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
      { :ok, changeset } ->
        conn
        |> put_session(:user_id, changeset.id)
        |> redirect(to: "/")
      { :error, changeset } ->
        render conn, :new, changeset: changeset
    end
  end
end
