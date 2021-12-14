defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{} = created_user}), do: {:ok, created_user}

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
