defmodule Curator.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :citext
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
