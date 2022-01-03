defmodule Rockelivery do
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Get, as: UserShow
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Update, as: UserUpdate
  alias Rockelivery.Users.Index, as: UserIndex

  alias Rockelivery.Items.Create, as: ItemCreate

  defdelegate index_users, to: UserIndex, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user(id), to: UserShow, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call

  defdelegate create_item(params), to: ItemCreate, as: :call
end
