defmodule Fawkes.Membership.User do
  use Ecto.Schema

  schema "users" do
    field(:username, :string)
    has_one(:profile, Fawkes.Membership.Profile)

    timestamps()
  end
end
