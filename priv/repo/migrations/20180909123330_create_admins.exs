defmodule Altstatus.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
