defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "creates the user", %{conn: conn} do
      params = build(:user_string_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      expected_response = %{
        "message" => "User created",
        "user" => %{
          "address" => "Rua",
          "age" => 18,
          "cpf" => "12345678911",
          "email" => "johndoe@email.com",
          "name" => "John Doe"
        }
      }

      assert expected_response = response
    end

    test "returns an error case there are invalid params", %{conn: conn} do
      params = %{
        "address" => "Rua",
        "age" => 18,
        "cpf" => "12345678911",
        "cep" => "09070410"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "cep" => ["can't be blank"],
          "email" => ["can't be blank"],
          "name" => ["can't be blank"],
          "password" => ["can't be blank"]
        }
      }

      assert expected_response = response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "deletes the user", %{conn: conn} do
      id = "236f8849-4a58-4aba-af5f-f34ceda98c11"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
