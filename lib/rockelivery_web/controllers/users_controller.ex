defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  import Rockelivery

  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- get_user(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
