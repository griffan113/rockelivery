defmodule Rockelivery do
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Get, as: UserShow
  alias Rockelivery.Users.Delete, as: UserDelete

  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user(id), to: UserShow, as: :by_id
end
