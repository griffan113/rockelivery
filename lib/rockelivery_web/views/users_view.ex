defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created",
      token: token,
      user: user
    }
  end

  def render("user.json", %{user: user}),
    do: %{
      user: %{
        id: user.id,
        name: user.name,
        age: user.age,
        cpf: user.cpf,
        address: user.address,
        email: user.email,
        orders: user.orders,
        inserted_at: user.inserted_at,
        updated_at: user.updated_at
      }
    }

  def render("users.json", %{users: users}), do: %{users: users}

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
