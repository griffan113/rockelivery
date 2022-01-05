defmodule Rockelivery.Items.Index do
  alias Rockelivery.{Item, Repo}

  def call() do
    Repo.all(Item)
  end
end
