defmodule RockeliveryWeb.OrdersController do
  use RockeliveryWeb, :controller

  import Rockelivery

  alias Rockelivery.Order
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Order{} = order} <- create_order(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", order: order)
    end
  end
end
