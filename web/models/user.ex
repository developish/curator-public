defmodule Curator.User do
  use Curator.Web, :model

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> unique_constraint(:email)
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/.+@.+/)
    |> validate_length(:password, min: 8)
    |> encrypt_password
  end

  def encrypt_password(changeset) do
    password = get_change(changeset, :password)

    # Only hash the password if present
    if is_binary(password) do
      hash = Comeonin.Bcrypt.hashpwsalt(password)
      put_change(changeset, :password_hash, hash)
    else
      changeset
    end
  end
end
