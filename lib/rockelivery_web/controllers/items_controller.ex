defmodule RockeliveryWeb.ItemsController do
  use RockeliveryWeb, :controller

  import Rockelivery

  alias Rockelivery.Item
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("items.json", items: index_items())
  end

  def create(conn, params) do
    with {:ok, %Item{} = item} <- create_item(params) do
      conn
      |> put_status(:created)
      |> render("create.json", item: item)
    end
  end

  def update(conn, params) do
    with {:ok, %Item{} = item} <- update_item(params) do
      conn
      |> put_status(:ok)
      |> render("item.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Item{}} <- delete_item(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
