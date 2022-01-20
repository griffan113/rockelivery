defmodule Rockelivery do
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Get, as: UserShow
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Update, as: UserUpdate
  alias Rockelivery.Users.Index, as: UserIndex

  alias Rockelivery.Items.Index, as: ItemIndex
  alias Rockelivery.Items.Delete, as: ItemDelete
  alias Rockelivery.Items.Create, as: ItemCreate
  alias Rockelivery.Items.Update, as: ItemUpdate

  alias Rockelivery.Orders.Create, as: OrderCreate
  alias Rockelivery.Orders.Index, as: OrderIndex

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call
  defdelegate index_users, to: UserIndex, as: :call
  defdelegate get_user(id), to: UserShow, as: :call

  defdelegate create_item(params), to: ItemCreate, as: :call
  defdelegate delete_item(id), to: ItemDelete, as: :call
  defdelegate update_item(params), to: ItemUpdate, as: :call
  defdelegate index_items, to: ItemIndex, as: :call

  defdelegate create_order(params), to: OrderCreate, as: :call
  defdelegate index_orders, to: OrderIndex, as: :call
end
