defmodule Altstatus.Resources.Submission do
  use Ecto.Schema
  import Ecto.Changeset


  schema "submissions" do
    field :medium_url, :string
    field :reflection, :string
    field :twitter_url, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:twitter_url, :reflection, :medium_url])
    |> validate_required([:twitter_url, :reflection, :medium_url])
  end
end
