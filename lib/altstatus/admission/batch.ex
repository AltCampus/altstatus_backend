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
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> slugify
  end

  def slugify(changeset) do
    if name = get_change(changeset, :name) do
      put_change(changeset, :slug, generate_slug(name))
    else
      changeset
    end
  end

  def generate_slug(name) do
    name
    |> String.trim
    |> String.downcase
    |> String.split([" ", ",", ", "])
    |> Enum.join("-")
  end
end
