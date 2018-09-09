defmodule Altstatus.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :batch_id, :id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :batch_id])
    |> validate_required([:name, :email, :password_hash, :batch_id])
    |> unique_constraint(:email)
    |> hash_password
  end

  def hash_password(changeset) do
    if password = get_change(changeset, :password) do
      put_change(changeset, :hashed_password, hashpwsalt(password))
    else
      changeset
    end
  end
end
