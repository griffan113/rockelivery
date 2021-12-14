defmodule RockeliveryWeb.Plugs.UUIDChecker do
  alias Plug.Conn
  alias Ecto.UUID

  import Plug.Conn

  def init(options), do: options

  # Like a NestJS guard
  def call(%Conn{params: %{"id" => id}} = conn, _options) do
    case UUID.cast(id) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  # Because some connections don't receive ID as a param
  def call(conn, _options), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{message: "Invalid UUID"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()

    # halt => Stop connection until the controller
  end
end
