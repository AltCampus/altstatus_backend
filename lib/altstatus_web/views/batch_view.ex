defmodule AltstatusWeb.BatchView do
  use AltstatusWeb, :view
  alias AltstatusWeb.BatchView

  def render("index.json", %{batches: batches}) do
    %{data: render_many(batches, BatchView, "batch.json")}
  end

  def render("show.json", %{batch: batch}) do
    %{data: render_one(batch, BatchView, "batch.json")}
  end

  def render("batch.json", %{batch: batch}) do
    %{id: batch.id,
      name: batch.name,
      slug: batch.slug}
  end
end
