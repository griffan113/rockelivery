defmodule RockeliveryWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :rockelivery

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  # Carrega o map do User no map de conexão (conn)
  plug Guardian.Plug.LoadResource
end
