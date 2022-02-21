defmodule Rockelivery.Users.Index do
  alias Rockelivery.{Repo, User}

  def call do
    Repo.all(User)
  end
end
