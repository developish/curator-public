defmodule Curator.Session do
  alias Curator.User

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :user_id)
    if id, do: Curator.Repo.get(User, id)
  end

  def sign_in(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))

    case authenticate(user, params["password"]) do
      true -> { :ok, user }
      _ -> { :error, params }
    end
  end

  def signed_in?(conn), do: !!current_user(conn)

  defp authenticate(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end
