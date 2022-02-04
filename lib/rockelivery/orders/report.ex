defmodule Rockelivery.Orders.Report do
  import Ecto.Query

  alias Rockelivery.{Repo, Order, Item}
  alias Rockelivery.Orders.TotalPrice

  @default_block_size 500

  def create(filename \\ "report.csv") do
    query = from(order in Order, order_by: order.user_id)

    {:ok, order_list} =
      Repo.transaction(fn ->
        query
        # Carrega de 500 em 500
        |> Repo.stream(max_rows: @default_block_size)
        # Corta o array de 500 em 500
        |> Stream.chunk_every(@default_block_size)
        # Volta para uma lista original, e para cada um desses blocos carrega os items de 500 em 500
        |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
        |> Enum.map(&parse_line/1)
      end)

    File.write(filename, order_list)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    items_string = Enum.map(items, fn item -> item_string(item) end)
    total_price = TotalPrice.calculate(items)

    "#{user_id},#{payment_method},#{items_string}#{total_price}\n"
  end

  defp item_string(%Item{category: category, description: description, price: price}) do
    "#{category},#{description},#{price},"
  end
end
