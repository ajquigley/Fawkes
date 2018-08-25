defmodule FawkesWeb.Signup.UserController do
  use FawkesWeb, :controller

  alias Fawkes.Signup
  alias Fawkes.Signup.User

  def new(conn, _params) do
    changeset = Signup.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Signup.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: schedule_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
