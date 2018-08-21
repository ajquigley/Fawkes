defmodule Fawkes.Schedule.Audience do
  @moduledoc """
  The relative experience level attendees should have to get the most out of a
  talk.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType

  @type t :: %__MODULE__{}

  @spec changeset(t, map) :: Changeset.t()

  schema "audiences" do
    field(:name, :string)
    field(:slug, SymbolType)

    timestamps()
  end

  @doc false
  def changeset(audience, attrs) do
    audience
    |> cast(attrs, [:slug, :name])
    |> validate_required([:slug, :name])
    |> unique_constraint(:slug)
  end
end
