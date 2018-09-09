defmodule Altstatus.Admission.Batch do
  use Ecto.Schema
  import Ecto.Changeset


  schema "batches" do
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(batch, attrs) do
    batch
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
    |> unique_constraint(:name)
  end
end
