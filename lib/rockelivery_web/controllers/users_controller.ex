defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  import Rockelivery

  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with %User{} = user <- create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
