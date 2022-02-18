defmodule RockeliveryWeb.Plugs.RateLimiter do
  alias Plug.Conn
  alias RockeliveryWeb.Auth.Guardian

  import Plug.Conn

  def init(options), do: options

  # Like a NestJS guard
  def call(%Conn{req_headers: req_headers} = conn, _options) do
    req_headers
    |> find_authorization_header()
    |> verify_token()
    |> handle_user_rate_limit(conn)
  end

  defp find_authorization_header(req_headers) do
    auth_header =
      Enum.find(req_headers, fn {header, _value} ->
        header === "authorization"
      end)

    case auth_header do
      nil -> {:error, "No authorization header"}
      header -> {:ok, header}
    end
  end

  defp verify_token({:ok, {"authorization", token}}) do
    [_bearer, parsed_token] = String.split(token, "Bearer ")

    with {:ok, %{"sub" => id}} <- Guardian.decode_and_verify(parsed_token) do
      {:ok, id}
    else
      error -> error
    end
  end

  defp verify_token({:error, error}), do: {:error, error}

  defp handle_user_rate_limit({:ok, id}, conn) do
    case Hammer.check_rate("app:#{id}", 60_000, 15) do
      {:allow, _count} ->
        conn

      {:deny, _limit} ->
        render_error(conn, :too_many_requests, "Too many requests")
    end
  end

  defp handle_user_rate_limit({:error, _error}, conn), do: conn

  defp render_error(conn, status, message) do
    body = Jason.encode!(%{message: message})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
    |> halt()
  end
end
