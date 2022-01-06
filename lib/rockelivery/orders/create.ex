defmodule Rockelivery.Order.Create do
  import Ecto.Query

  alias Rockelivery.{Repo, Item}

  def call(params) do
    params
    |> fetch_items()
  end

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    # Aqui é usado o pin operator por que se não o Ecto tenta fazer pattern matching com o items_ids
    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> validate_items(items_ids)
  end

  defp validate_items(items, items_ids) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    items_ids
    |> Enum.map(fn id -> {id, Map.get(items_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
  end
end
