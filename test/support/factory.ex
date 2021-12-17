defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      address: "Rua",
      age: 18,
      cep: "09070410",
      cpf: "12345678911",
      email: "johndoe@email.com",
      password: "12345678",
      name: "John Doe"
    }
  end

  def user_string_params_factory do
    %{
      "address" => "Rua",
      "age" => 18,
      "cep" => "09070410",
      "cpf" => "12345678911",
      "email" => "johndoe@email.com",
      "password" => "12345678",
      "name" => "John Doe"
    }
  end

  def user_factory do
    %User{
      address: "Rua",
      age: 18,
      cep: "09070410",
      cpf: "12345678911",
      email: "johndoe@email.com",
      password: "12345678",
      name: "John Doe",
      id: "236f8849-4a58-4aba-af5f-f34ceda98c11"
    }
  end
end
