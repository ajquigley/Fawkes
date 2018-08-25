defmodule Fawkes.Auth do
  @moduledoc """
  The Auth context.
  """
  import Ecto.Query, warn: false
  alias Fawkes.Repo
  alias Fawkes.Auth.User
  alias Comeonin.Bcrypt

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def authenticate_user(%{"username" => user, "password" => pass}) do
    user
    |> fetch_user_by_username()
    |> check_password(pass)
  end

  def fetch_user_by_username(username) do
    User
    |> where([user], user.username == ^username)
    |> Repo.one
  end

  defp check_password(%User{} = user, password) do
    password
    |> Bcrypt.checkpw(user.password)
    |> case do
      true ->
        {:ok, user}
      false ->
        Bcrypt.dummy_checkpw()
        {:error, :incorrect}
    end
  end

  defp check_password(_, _), do: {:error, :incorrect}
end
