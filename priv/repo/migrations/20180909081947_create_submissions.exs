defmodule Altstatus.Repo.Migrations.CreateSubmissions do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :twitter_url, :string
      add :reflection, :text
      add :medium_url, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:submissions, [:user_id])
  end
end
