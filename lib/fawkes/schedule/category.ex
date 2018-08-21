defmodule Fawkes.Schedule.Category do
  @moduledoc """
  The topic of a talk
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType

  @type t :: %__MODULE__{}

  @spec changeset(t, map) :: Changeset.t()

  schema "categories" do
    field(:name, :string)
    field(:slug, SymbolType)

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:slug, :name])
    |> validate_required([:slug, :name])
    |> unique_constraint(:slug)
  end
end
