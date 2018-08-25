defmodule Fawkes.Membership.Profile do
  @moduledoc false

  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType

  schema "profiles" do
    field(:company, :string)
    field(:description, :string)
    field(:first, :string)
    field(:github, :string)
    field(:image, Fawkes.Uploader.Image.Type)
    field(:last, :string)
    field(:slug, SymbolType)
    field(:twitter, :string)
    field(:title, :string)

    belongs_to(:user, Fawkes.Membership.User)

    timestamps()
  end

  @doc false
  def init_changeset(info, attrs) do
    info
    |> cast(attrs, [:user_id, :slug])
    |> validate_required([:user_id, :slug])
    |> unique_constraint(:user_id)
    |> unique_constraint(:slug)
  end

  @doc false
  def changeset(info, attrs) do
    info
    |> cast(attrs, [:first, :last, :slug, :company, :title, :github, :twitter,
                    :description, :image])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:first, :last])
    |> validate_exclusion(:slug, [:edit, :new])
    |> unique_constraint(:slug)
  end
end
