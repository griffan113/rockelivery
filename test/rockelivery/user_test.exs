defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "John Doe"}, valid?: true} = response
    end

    test "returns a valid changeset when passing a struct" do
      params = params = build(:user_params)

      changeset = User.changeset(params)

      update_params = %{name: "John"}

      response = User.changeset(changeset, update_params)

      assert %Changeset{changes: %{name: "John"}, valid?: true} = response
    end

    test "returns an error case the changeset is invalid" do
      params = params = build(:user_string_params, %{"age" => 15})

      response = User.changeset(params)

      expected_response = %{age: ["must be greater than or equal to 18"]}

      assert errors_on(response) == expected_response
    end
  end
end
