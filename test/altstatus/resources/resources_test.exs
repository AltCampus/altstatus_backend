defmodule Altstatus.ResourcesTest do
  use Altstatus.DataCase

  alias Altstatus.Resources

  describe "submissions" do
    alias Altstatus.Resources.Submission

    @valid_attrs %{medium_url: "some medium_url", reflection: "some reflection", twitter_url: "some twitter_url"}
    @update_attrs %{medium_url: "some updated medium_url", reflection: "some updated reflection", twitter_url: "some updated twitter_url"}
    @invalid_attrs %{medium_url: nil, reflection: nil, twitter_url: nil}

    def submission_fixture(attrs \\ %{}) do
      {:ok, submission} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_submission()

      submission
    end

    test "list_submissions/0 returns all submissions" do
      submission = submission_fixture()
      assert Resources.list_submissions() == [submission]
    end

    test "get_submission!/1 returns the submission with given id" do
      submission = submission_fixture()
      assert Resources.get_submission!(submission.id) == submission
    end

    test "create_submission/1 with valid data creates a submission" do
      assert {:ok, %Submission{} = submission} = Resources.create_submission(@valid_attrs)
      assert submission.medium_url == "some medium_url"
      assert submission.reflection == "some reflection"
      assert submission.twitter_url == "some twitter_url"
    end

    test "create_submission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_submission(@invalid_attrs)
    end

    test "update_submission/2 with valid data updates the submission" do
      submission = submission_fixture()
      assert {:ok, submission} = Resources.update_submission(submission, @update_attrs)
      assert %Submission{} = submission
      assert submission.medium_url == "some updated medium_url"
      assert submission.reflection == "some updated reflection"
      assert submission.twitter_url == "some updated twitter_url"
    end

    test "update_submission/2 with invalid data returns error changeset" do
      submission = submission_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_submission(submission, @invalid_attrs)
      assert submission == Resources.get_submission!(submission.id)
    end

    test "delete_submission/1 deletes the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{}} = Resources.delete_submission(submission)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_submission!(submission.id) end
    end

    test "change_submission/1 returns a submission changeset" do
      submission = submission_fixture()
      assert %Ecto.Changeset{} = Resources.change_submission(submission)
    end
  end
end
