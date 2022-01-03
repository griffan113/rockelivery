defmodule RockeliveryWeb.WelcomeController do
  use RockeliveryWeb, :controller

  def index(conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome"})
  end
end
