defmodule AltstatusWeb.BatchController do
  use AltstatusWeb, :controller

  alias Altstatus.Admission
  alias Altstatus.Admission.Batch

  action_fallback AltstatusWeb.FallbackController

  def index(conn, _params) do
    batches = Admission.list_batches()
    render(conn, "index.json", batches: batches)
  end

  def create(conn, %{"batch" => batch_params}) do
    with {:ok, %Batch{} = batch} <- Admission.create_batch(batch_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", batch_path(conn, :show, batch))
      |> render("show.json", batch: batch)
    end
  end

  def show(conn, %{"id" => id}) do
    batch = Admission.get_batch!(id)
    render(conn, "show.json", batch: batch)
  end

  def update(conn, %{"id" => id, "batch" => batch_params}) do
    batch = Admission.get_batch!(id)

    with {:ok, %Batch{} = batch} <- Admission.update_batch(batch, batch_params) do
      render(conn, "show.json", batch: batch)
    end
  end

  def delete(conn, %{"id" => id}) do
    batch = Admission.get_batch!(id)
    with {:ok, %Batch{}} <- Admission.delete_batch(batch) do
      send_resp(conn, :no_content, "")
    end
  end
end
