defmodule Altstatus.Repo.Migrations.CreateBatches do
  use Ecto.Migration

  def change do
    create table(:batches) do
      add :name, :string
      add :slug, :string

      timestamps()
    end

    create unique_index(:batches, [:name])
  end
end
