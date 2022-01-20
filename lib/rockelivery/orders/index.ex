defmodule Rockelivery.Orders.Index do
  alias Rockelivery.{Order, Repo}

  def call() do
    Repo.all(Order)
    |> Repo.preload(:items)
  end
end
