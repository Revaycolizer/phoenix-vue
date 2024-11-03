defmodule MyPhoenix.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias MyPhoenix.Repo

  alias MyPhoenix.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(id, user_params) when is_integer(id) do
    user = Repo.get(User, id)
  
    case user do
      nil -> 
        {:error, :not_found}
  
      user -> 
        changeset = User.changeset(user, user_params)
        Repo.update(changeset)
    end
  end
  
  def update_user(id, user_params) when is_binary(id) do
    case String.to_integer(id) do
      int_id -> update_user(int_id, user_params)  
      _ -> {:error, :invalid_id} 
    end
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> delete_user()
  end
  
  def delete_user(id) when is_integer(id) do
    user = Repo.get(User, id)
  
    case user do
      nil -> 
        {:error, :not_found}
  
      user -> 
        Repo.delete(user)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
