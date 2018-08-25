defmodule Fawkes.Signup.User do
  use Ecto.Schema
  import Ecto.Changeset

  @bad_passwords ~w(
    12345678
    password1
    qwertyuiop
  )

  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> validate_exclusion(
         :password,
         @bad_passwords,
         message: "That password is too common.")
    |> validate_length(:password, min: 8)
    |> put_pass_hash()
  end

  defp put_pass_hash(%{valid?: true, changes: params} = changeset) do
    password = Comeonin.Bcrypt.hashpwsalt(params[:password])
    change(changeset, password: password)
  end

  defp put_pass_hash(changeset) do
    change(changeset, password: "")
  end
end
