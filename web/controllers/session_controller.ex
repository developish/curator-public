defmodule Curator.SessionController do
  use Curator.Web, :controller

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"session" => session_params}) do
    case Curator.Session.sign_in(session_params, Repo) do
      { :ok, user } ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Signed in successfully")
        |> redirect(to: "/")
      { :error, params } ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render(:new)
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Signed out")
    |> redirect(to: "/")
  end
end
