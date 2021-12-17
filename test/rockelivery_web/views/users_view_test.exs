defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert response = %{
             message: "User created",
             user: %Rockelivery.User{
               address: "Rua",
               age: 18,
               cep: "09070410",
               cpf: "12345678911",
               email: "johndoe@email.com",
               id: "236f8849-4a58-4aba-af5f-f34ceda98c11",
               inserted_at: nil,
               name: "John Doe",
               password: "12345678",
               password_hash: nil,
               updated_at: nil
             }
           }
  end
end
