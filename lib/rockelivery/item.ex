defmodule Rockelivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]

  @update_params @required_params -- [:password]

  @items_category_enum [:food, :drink, :desert]

  # Igual class-validator
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :category, Ecto.Enum, values: @items_category_enum
    field :description, :string
    field :price, :decimal
    field :photo, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)

    # Faz a validação dos campos baseado nos parametros recebidos
  end

  def changeset(struct, params) do
    struct
    |> cast(params, @update_params)
    |> validate_required(@update_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)

    # Faz a validação dos campos baseado nos parametros recebidos
  end
end
