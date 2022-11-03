defmodule PasswordGeneratorWeb.Api.PageControllerTest do
  use PasswordGeneratorWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "generate a password" do
    test "generate a password with only length", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "6"})
      assert %{"password" => _pass} = json_response(conn, 200)
    end

    test "generate a password with one option", %{conn: conn} do
      options = %{
        "length" => "6",
        "numbers" => "true"
      }

      conn = post(conn, Routes.page_path(conn, :api_generate), options)
      assert %{"password" => _pass} = json_response(conn, 200)
    end
  end

  describe "return errors" do
    test "error when no options", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{})
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when length not integer", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "ab"})
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when options not bool", %{conn: conn} do
      options = %{
        "length" => "6",
        "invalid" => "invalid"
      }

      conn = post(conn, Routes.page_path(conn, :api_generate), options)
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when onot valid options", %{conn: conn} do
      options = %{
        "length" => "6",
        "invalid" => "true"
      }

      conn = post(conn, Routes.page_path(conn, :api_generate), options)
      assert %{"error" => _error} = json_response(conn, 200)
    end
  end
end
