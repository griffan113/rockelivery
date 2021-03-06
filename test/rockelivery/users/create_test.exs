defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock
  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create

  describe "call/1" do
    test "creates the user" do
      params = build(:user_string_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{age: 18}} = response
    end

    test "returns an error if there are invalid params" do
      params = build(:user_string_params, %{"age" => 15})

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      expected_response = %{age: ["must be greater than or equal to 18"]}

      assert errors_on(changeset) == expected_response
    end
  end
end
