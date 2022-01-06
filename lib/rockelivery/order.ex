defmodule Rockelivery.Order do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rockelivery.{Item, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:address, :comments, :payment_method, :user_id]

  @payment_method_enum [:money, :credit_card, :debit_card]

  # Igual class-validator
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "orders" do
    field :payment_method, Ecto.Enum, values: @payment_method_enum
    field :address, :string
    field :comments, :string

    many_to_many :items, Item, join_through: "orders_items"
    belongs_to :user, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> cast(params, @required_params)
    |> put_assoc(:items, items)
    |> validate_required(@required_params)
    |> validate_length(:address, min: 10)
    |> validate_length(:comments, min: 6)

    # put_assoc -> Os items já existem, eles já estão pre-configurados |> Relaciona os items já cadastrados com o pedido
    # Faz a validação dos campos baseado nos parametros recebidos
  end
end
