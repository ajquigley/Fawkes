defmodule Fawkes.Membership do
  @moduledoc """
  Context responsible for managing profile information
  """

  import Ecto.Query
  alias Fawkes.Membership.User
  alias Fawkes.Repo

  def get_user(id) do
    User
    |> where([user], user.id == ^id)
    |> Repo.one()
  end
end
