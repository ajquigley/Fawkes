defmodule Fawkes.Schedule.Speaker do
  @moduledoc """
  The person given a talk
  """

  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType

  @type t :: %__MODULE__{}

  @spec changeset(t, map) :: Changeset.t()

  schema "profiles" do
    field(:company, :string)
    field(:title, :string)
    field(:description, :string)
    field(:first, :string)
    field(:github, :string)
    field(:last, :string)
    field(:slug, SymbolType)
    field(:twitter, :string)
    field(:image, Fawkes.Uploader.Image.Type)

    has_one(:talk, Fawkes.Schedule.Talk)

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [:slug, :image, :first, :last, :company, :github, :twitter, :description])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:slug, :image, :first, :last, :description])
    |> unique_constraint(:slug)
  end
end
