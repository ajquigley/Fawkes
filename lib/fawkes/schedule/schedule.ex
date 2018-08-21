defmodule Fawkes.Schedule do
  @moduledoc """
  Module responsible for the schedule domain
  """

  import Ecto.Query
  alias Fawkes.Repo
  alias Fawkes.Schedule.Slot
  alias Fawkes.Schedule.Speaker
  alias Fawkes.Schedule.Talk

  @type slugable :: Fawkes.Repo.Symbol.t()

  @spec fetch() :: list(Slot.t())
  @spec fetch(list(pos_integer) | slugable) :: list(Slot.t()) | Slot.t()
  @spec fetch_by_audience(slugable) :: list(Slot.t())
  @spec fetch_by_category(slugable) :: list(Slot.t())
  @spec fetch_by_location(slugable) :: list(Slot.t())
  @spec fetch_for_talks(list(pos_integer)) :: list(Slot.t())
  @spec fetch_speakers() :: list(Speaker.t())
  @spec fetch_speakers(slugable) :: Speaker.t()
  @spec fetch_talks(slugable) :: Talk.t()
  @spec single_talk_slot_talk_ids() :: list(pos_integer)
  @spec to_talk_ids(list(Slot.t())) :: list(pos_integer)

  defdelegate seed(), to: Fawkes.Schedule.Seed, as: :perform

  @doc """
  Returns a list of all slots in the schedule.
  """
  def fetch do
    Slot
    |> preload([:event, [talks: [:speaker, :category, :audience, :location]]])
    |> order_by([slot], slot.start)
    |> Repo.all()
  end

  @doc """
  Given a list of talk_ids returns a list of slots which are related to those
  talk ids.

  This method returns talks through Fawkes.Schedule.Agenda.  All talks returned
  are marked `selected? = true`
  """
  def fetch(talk_ids) when is_list(talk_ids) do
    __MODULE__.Agenda.fetch(talk_ids)
  end

  @doc """
  Given a string or atom used as an audience slug - returns the related slot.
  """
  def fetch(slug) do
    Slot
    |> where([slot], slot.slug == ^slug)
    |> preload(talks: [:speaker, :category, :audience, :location])
    |> Repo.one()
  end

  @doc """
  Given a string or atom used as an audience slug - returns a list of slots.

  Only talks related to the slug are returned.
  Only slugs containing talks are returned.
  """
  def fetch_by_audience(slug) do
    Slot
    |> join(:left, [slot], talks in assoc(slot, :talks))
    |> join(:left, [_slot, talks], audiences in assoc(talks, :audience))
    |> where([_slot, _talks, audiences], audiences.slug == ^slug)
    |> preload([_, talks], [:event, [talks: {talks, [:speaker, :category, :audience, :location]}]])
    |> order_by([slot], slot.start)
    |> Repo.all()
  end

  @doc """
  Given a string or atom used as an audience slug - returns a list of slots.

  Only talks related to the slug are returned.
  Only slugs containing talks are returned.
  """
  def fetch_by_category(slug) do
    Slot
    |> join(:left, [slot], talks in assoc(slot, :talks))
    |> join(:left, [_slot, talks], categories in assoc(talks, :category))
    |> where([_slot, _talks, categories], categories.slug == ^slug)
    |> preload([_, talks], [:event, [talks: {talks, [:speaker, :category, :audience, :location]}]])
    |> order_by([slot], slot.start)
    |> Repo.all()
  end

  @doc """
  Given a string or atom used as an location slug - returns a list of slots.

  Only talks related to the slug are returned.
  Only slugs containing talks are returned.
  """
  def fetch_by_location(slug) do
    Slot
    |> join(:left, [slot], talks in assoc(slot, :talks))
    |> join(:left, [_slot, talks], locations in assoc(talks, :location))
    |> where([_slot, _talks, locations], locations.slug == ^slug)
    |> preload([_, talks], [:event, [talks: {talks, [:speaker, :category, :audience, :location]}]])
    |> order_by([slot], slot.start)
    |> Repo.all()
  end

  @doc """
  Given a list of talk_ids returns all slots which contain the related talks
  preloaded with only the related talks.  This method will not preload events.
  """
  def fetch_for_talks(talk_ids) do
    Slot
    |> join(:inner, [slot], talks in assoc(slot, :talks))
    |> where([_slot, talks], talks.id in ^talk_ids)
    |> preload([_, talks], talks: {talks, [:speaker, :category, :audience, :location]})
    |> order_by([slot], slot.start)
    |> Repo.all()
  end

  @doc """
  Returns a list of all speakers.
  """
  def fetch_speakers do
    Speaker
    |> join(:right, [speaker], talk in assoc(speaker, :talk))
    |> preload([:talk])
    |> order_by([speaker], speaker.last)
    |> Repo.all()
  end

  @doc """
  Given a string or atom used as a speaker slug - returns the related speaker.
  """
  def fetch_speakers(slug) do
    Speaker
    |> join(:right, [speaker], talk in assoc(speaker, :talk))
    |> where([speaker], speaker.slug == ^slug)
    |> preload([:talk])
    |> Repo.one()
  end

  @doc """
  Given a string or atom used as a talk slug - returns the related talk.
  """
  def fetch_talks(slug) do
    Talk
    |> where([talk], talk.slug == ^slug)
    |> preload([:slot, :speaker, :category, :audience, :location])
    |> Repo.one()
  end

  @doc """
  Returns a list of ids from all talks which are the only talk in their schedule
  slot
  """
  def single_talk_slot_talk_ids do
    Talk
    |> where([talk], fragment("? in (SELECT slot_id
                                     FROM talks
                                     GROUP BY slot_id
                                     HAVING count(slot_id) = 1)", talk.slot_id))
    |> select([talk], talk.id)
    |> Repo.all()
  end

  @doc """
  Given a list of schedule slots returns a list of all talk_ids contained in
  those slots.
  """
  def to_talk_ids(slots) do
    Enum.reduce(slots, [], fn slot, acc ->
      slot.talks
      |> Enum.reduce([], fn talk, acc ->
        [talk.id | acc]
      end)
      |> Kernel.++(acc)
    end)
  end
end
