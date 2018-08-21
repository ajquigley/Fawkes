defmodule Fawkes.Schedule.Seed.Event do
  @moduledoc false

  import Ecto.Query
  alias Fawkes.Repo
  alias Fawkes.Schedule.Event
  alias Fawkes.Schedule.Slot

  def perform do
    Slot
    |> fetch_all_by_slug()
    |> data()
    |> Enum.each(fn attrs ->
      %Event{}
      |> Event.changeset(attrs)
      |> Repo.insert()
    end)
  end

  def data(relations) do
    [
      %{
        slug: :day_1_registration,
        name: "Registration",
        slot_id: relations[:slot_1]
      },
      %{
        slug: :day_1_welcome,
        name: "Welcome",
        slot_id: relations[:slot_2]
      },
      %{
        slug: :break_1,
        name: "Break",
        slot_id: relations[:slot_4]
      },
      %{
        slug: :day_1_lunch,
        name: "Lunch",
        slot_id: relations[:slot_7]
      },
      %{
        slug: :break_2,
        name: "Break",
        slot_id: relations[:slot_a]
      },
      %{
        slug: :break_3,
        name: "Break",
        slot_id: relations[:slot_d]
      },
      %{
        slug: :lightning_talks,
        name: "Lightning Talks",
        slot_id: relations[:slot_e]
      },
      %{
        slug: :day_2_registration,
        name: "Registration",
        slot_id: relations[:slot_f]
      },
      %{
        slug: :day_2_welcome,
        name: "Welcome",
        slot_id: relations[:slot_g]
      },
      %{
        slug: :break_4,
        name: "Break",
        slot_id: relations[:slot_i]
      },
      %{
        slug: :day_2_lunch,
        name: "Lunch",
        slot_id: relations[:slot_l]
      },
      %{
        slug: :break_5,
        name: "Break",
        slot_id: relations[:slot_o]
      },
      %{
        slug: :break_6,
        name: "Break",
        slot_id: relations[:slot_r]
      },
      %{
        slug: :closing_remarks,
        name: "Closing Remarks",
        slot_id: relations[:slot_s]
      }
    ]
  end

  defp fetch_all_by_slug(query) do
    query
    |> select([item], %{slug: item.slug, id: item.id})
    |> Repo.all()
    |> Enum.reduce(%{}, fn %{slug: slug, id: id}, acc ->
      Map.put(acc, slug, id)
    end)
  end
end
