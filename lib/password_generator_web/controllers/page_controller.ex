defmodule PasswordGeneratorWeb.PageController do
  use PasswordGeneratorWeb, :controller

  alias PasswordGenerator.Passwords
  alias PasswordGenerator.Passwords.Password

  require Logger

  def index(conn, _params, password_lengths, passwords) do
    conn
    |> assign(:password_length, password_lengths)
    |> assign(:password, "")
    |> assign(:passwords, passwords)
    |> render("index.html")
  end

  def generate(conn, %{"password" => password_params}, password_lengths, passwords) do
    {:ok, password} = PwGenerator.generate(password_params)

    create(%{"password" => password})

    conn
    |> assign(:password_length, password_lengths)
    |> assign(:password, password)
    |> assign(:passwords, passwords)
    |> render("index.html")
  end

  def action(conn, _) do
    password_lengths = [
      Rare: Enum.map(6..8, & &1),
      Medium: Enum.map(9..12, & &1),
      Well: Enum.map(13..18, & &1)
    ]

    passwords = Passwords.list_passwords()

    args = [conn, conn.params, password_lengths, passwords]
    apply(__MODULE__, action_name(conn), args)
  end

  def create(%{"password" => password}) do
    case Passwords.create_password(%{"password" => password}) do
      {:ok, _password} ->
        {:ok, "Created"}

      {:error, %Ecto.Changeset{} = password} ->
        Logger.info("Senha não gerada", password)
    end
  end
end
