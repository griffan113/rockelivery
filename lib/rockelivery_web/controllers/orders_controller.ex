defmodule RockeliveryWeb.OrdersController do
  use RockeliveryWeb, :controller

  import Rockelivery

  alias Rockelivery.Order
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Order{} = order} <- create_order(params) do
      conn
      |> put_status(:created)
      |> render("create.json", order: order)
    end
  end

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("index.json", orders: index_orders())
  end
end
