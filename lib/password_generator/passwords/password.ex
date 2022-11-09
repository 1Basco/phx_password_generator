defmodule PasswordGenerator.Passwords.Password do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passwords" do
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(password, attrs) do
    password
    |> cast(attrs, [:password])
    |> validate_required([:password])
  end
end
