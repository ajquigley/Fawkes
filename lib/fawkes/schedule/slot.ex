defmodule Fawkes.Schedule.Slot do
  @moduledoc """
  Slots are the time slots which make up the building blocks of a schedule.

  Slots should have either one event or n available talks.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Fawkes.Repo.Symbol, as: SymbolType
  alias Fawkes.Schedule.Event
  alias Fawkes.Schedule.Talk

  @type t :: %__MODULE__{}

  @spec changeset(t, map) :: Changeset.t()

  schema "schedule_slots" do
    field(:finish, :naive_datetime)
    field(:slug, SymbolType)
    field(:start, :naive_datetime)
    field(:none_selected?, :boolean, default: false, virtual: true)

    has_one(:event, Event)
    has_many(:talks, Talk)

    timestamps()
  end

  @doc false
  def changeset(slot, attrs) do
    slot
    |> cast(attrs, [:slug, :start, :finish])
    |> validate_required([:slug, :start, :finish])
    |> unique_constraint(:slug)
  end
end
