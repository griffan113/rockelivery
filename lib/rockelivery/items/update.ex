defmodule Rockelivery.Items.Update do
  alias Rockelivery.{Error, Repo, Item}

  def call(%{"id" => id} = params) do
    case Repo.get(Item, id) do
      nil -> {:error, Error.build_item_not_found_error()}
      item -> do_update(item, params)
    end
  end

  defp do_update(item, params) do
    IO.inspect(Item.changeset(item, params), label: "#################")

    item
    |> Item.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Item{} = updated_item}), do: {:ok, updated_item}

  defp handle_update({:error, changeset}), do: {:error, Error.build(:bad_request, changeset)}
end
