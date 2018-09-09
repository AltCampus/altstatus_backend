defmodule Altstatus.AdmissionTest do
  use Altstatus.DataCase

  alias Altstatus.Admission

  describe "batches" do
    alias Altstatus.Admission.Batch

    @valid_attrs %{name: "some name", slug: "some slug"}
    @update_attrs %{name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def batch_fixture(attrs \\ %{}) do
      {:ok, batch} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admission.create_batch()

      batch
    end

    test "list_batches/0 returns all batches" do
      batch = batch_fixture()
      assert Admission.list_batches() == [batch]
    end

    test "get_batch!/1 returns the batch with given id" do
      batch = batch_fixture()
      assert Admission.get_batch!(batch.id) == batch
    end

    test "create_batch/1 with valid data creates a batch" do
      assert {:ok, %Batch{} = batch} = Admission.create_batch(@valid_attrs)
      assert batch.name == "some name"
      assert batch.slug == "some slug"
    end

    test "create_batch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admission.create_batch(@invalid_attrs)
    end

    test "update_batch/2 with valid data updates the batch" do
      batch = batch_fixture()
      assert {:ok, batch} = Admission.update_batch(batch, @update_attrs)
      assert %Batch{} = batch
      assert batch.name == "some updated name"
      assert batch.slug == "some updated slug"
    end

    test "update_batch/2 with invalid data returns error changeset" do
      batch = batch_fixture()
      assert {:error, %Ecto.Changeset{}} = Admission.update_batch(batch, @invalid_attrs)
      assert batch == Admission.get_batch!(batch.id)
    end

    test "delete_batch/1 deletes the batch" do
      batch = batch_fixture()
      assert {:ok, %Batch{}} = Admission.delete_batch(batch)
      assert_raise Ecto.NoResultsError, fn -> Admission.get_batch!(batch.id) end
    end

    test "change_batch/1 returns a batch changeset" do
      batch = batch_fixture()
      assert %Ecto.Changeset{} = Admission.change_batch(batch)
    end
  end
end
