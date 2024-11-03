defmodule MyPhoenix.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyPhoenix.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> MyPhoenix.Accounts.create_user()

    user
  end
end
