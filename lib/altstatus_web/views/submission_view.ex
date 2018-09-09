defmodule AltstatusWeb.SubmissionView do
  use AltstatusWeb, :view
  alias AltstatusWeb.SubmissionView

  def render("index.json", %{submissions: submissions}) do
    %{data: render_many(submissions, SubmissionView, "submission.json")}
  end

  def render("show.json", %{submission: submission}) do
    %{data: render_one(submission, SubmissionView, "submission.json")}
  end

  def render("submission.json", %{submission: submission}) do
    %{id: submission.id,
      twitter_url: submission.twitter_url,
      reflection: submission.reflection,
      medium_url: submission.medium_url,
      timestamp: submission.inserted_at
    }
  end
end
