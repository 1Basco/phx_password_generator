defmodule PasswordGenerator.Repo.Migrations.AddPasswordsTable do
  use Ecto.Migration

  def change do
    create table("passwords") do
      add :password, :string
      timestamps()
    end
  end
end
