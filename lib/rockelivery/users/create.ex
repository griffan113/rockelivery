defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.ViaCep.Client

  def call(params) do
    cep = Map.get(params, "cep")

    with {:ok, %User{}} <- User.build(params),
         {:ok, _cep_info} <- Client.get_cep_info(cep),
         {:ok, %User{} = user} <- create_user(params) do
      {:ok, user}
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
