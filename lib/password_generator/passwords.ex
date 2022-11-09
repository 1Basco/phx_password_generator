defmodule PasswordGenerator.Passwords do
  import Ecto.Query, warn: false

  alias PasswordGenerator.Repo

  alias PasswordGenerator.Passwords.Password

  @doc """
  Returns the list of passwords.
  
  ## Examples
  
      iex> list_passwords()
      [%Password{}, ...]
  
  """
  def list_passwords do
    Password
    |> order_by(desc: :id)
    |> limit(10)
    |> Repo.all()
  end

  @doc """
  Gets a single password.
  
  Raises `Ecto.NoResultsError` if the password does not exist.
  
  ## Examples
  
      iex> get_password!(123)
      %Password{}
  
      iex> get_password!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_password!(id), do: Repo.get!(Password, id)

  @doc """
  Gets last password.
  
  Raises `Ecto.NoResultsError` if the password does not exist.
  
  """
  def get_last_password do
    Password
    |> order_by(desc: :id)
    |> limit(10)
    |> Repo.one()
  end

  def create_password(attrs \\ %{}) do
    %Password{}
    |> Password.changeset(attrs)
    |> Repo.insert()
  end
end
