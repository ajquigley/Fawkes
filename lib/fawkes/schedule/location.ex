defmodule Fawkes.Schedule.Location do
  @moduledoc """
  Where the talk will be located.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType

  @type t :: %__MODULE__{}

  @spec changeset(t, map) :: Changeset.t()

  schema "locations" do
    field(:name, :string)
    field(:slug, SymbolType)

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:slug, :name])
    |> validate_required([:slug, :name])
    |> unique_constraint(:slug)
  end
end
