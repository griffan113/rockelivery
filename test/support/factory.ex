defmodule Rockelivery.Factory do
  use ExMachina

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
end
