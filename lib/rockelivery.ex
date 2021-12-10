defmodule Rockelivery do
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Get, as: GetUser

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user(id), to: GetUser, as: :by_id
end
