defmodule PasswordGeneratorWeb.PageController do
  use PasswordGeneratorWeb, :controller

  require Logger

  def index(conn, _params, password_lengths) do

    conn
    |> assign(:password_length, password_lengths)
    |> assign(:password, "")
    |> render("index.html")
  end

  def generate(conn, %{"password" => password_params}, password_lengths) do

    {:ok, password} = PwGenerator.generate(password_params)

    conn
    |> assign(:password_length, password_lengths)
    |> assign(:password, password)
    |> render("index.html")

  end

  def action(conn, _) do
    password_lengths = [
      Rare: Enum.map(6..8, & &1),
      Medium: Enum.map(9..12, & &1),
      Well: Enum.map(13..18, & &1)
    ]

    args = [conn, conn.params, password_lengths]
    apply(__MODULE__, action_name(conn), args)

  end

end
