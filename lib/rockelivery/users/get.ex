defmodule Rockelivery.Users.Get do
  alias Rockelivery.{Error, Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, Repo.preload(user, :orders)}
    end
  end
end
