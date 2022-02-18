defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.Users.Get, as: UserGet
  alias Rockelivery.Orders.ValidateAndMultiplyItems
  alias Rockelivery.{Repo, Item, Order, Error, User}

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    # Aqui é usado o pin operator por que se não o Ecto tenta fazer pattern matching com o items_ids
    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(items_ids, items_params)
  end

  defp handle_items({:ok, items}, params) do
    with {:ok, %User{}} <- UserGet.call(params["user_id"]) do
      params
      |> Order.changeset(items)
      |> Repo.insert()
      |> handle_insert()
    end
  end

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_insert({:ok, %Order{}} = order), do: order
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
