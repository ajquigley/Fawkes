defmodule FawkesWeb.CalendarHelpers do
  def group_schedule_by_dates(slots) do
    Enum.group_by(slots, fn slot -> slot.start |> NaiveDateTime.to_date() end)
  end
end
