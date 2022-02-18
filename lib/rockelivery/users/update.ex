defmodule Rockelivery.Users.Update do
  alias Rockelivery.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %User{} = updated_user}),
    do: {:ok, Repo.preload(updated_user, :orders)}

  defp handle_update({:error, changeset}), do: {:error, Error.build(:bad_request, changeset)}
end
