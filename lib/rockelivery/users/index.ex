defmodule Rockelivery.Users.Index do
  alias Rockelivery.{User, Repo}

  def call do
    Repo.all(User)
    |> Repo.preload(:orders)
  end
end
