defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.ViaCep.Client

  def call(%{"cep" => cep} = params) do
    with {:ok, %User{}} <- User.build(params),
         {:ok, _cep_info} <- Client.get_cep_info(cep),
         {:ok, %User{} = user} <- create_user(params) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  def create_user(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
