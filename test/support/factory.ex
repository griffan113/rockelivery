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

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
