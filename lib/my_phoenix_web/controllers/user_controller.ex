

defmodule MyPhoenixWeb.UserController do
  use MyPhoenixWeb, :controller

  alias MyPhoenix.Accounts
  alias MyPhoenix.Accounts.User

  # GET /api/v1/users
  def index(conn, _params) do
    users = Accounts.list_users()
    json(conn, users)
  end

  # GET /api/v1/users/:id
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    json(conn, user)
  end

  # POST /api/v1/users
  def create(conn, %{"email" => email, "name" => name}) do
    user_params = %{"email" => email, "name" => name}
  
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> json(user)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset.errors})
    end
  end

  # PUT /api/v1/users/:id
  def update(conn, %{"id" => id, "email" => email, "name" => name}) do
    user_params = %{"email" => email, "name" => name}
    IO.inspect(user_params, label: "User params received")
    case Accounts.update_user(id, user_params) do
      {:ok, %User{} = user} ->
        json(conn, user)  
  
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Unable to update user", details: changeset})
    end
  end

  # DELETE /api/v1/users/:id
  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Accounts.delete_user(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
