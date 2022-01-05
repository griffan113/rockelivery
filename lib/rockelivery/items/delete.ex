defmodule Rockelivery.Items.Delete do
  alias Rockelivery.{Repo, Item, Error}

  def call(id) do
    case Repo.get(Item, id) do
      nil -> {:error, Error.build_item_not_found_error()}
      item -> Repo.delete(item)
    end
  end
end
