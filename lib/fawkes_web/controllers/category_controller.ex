defmodule FawkesWeb.CategoryController do
  use FawkesWeb, :controller
  import FawkesWeb.CalendarHelpers

  def show(conn, %{"id" => id}) do
    schedule = Schedule.fetch_by_category(id)

    render(
      conn,
      FawkesWeb.ScheduleView,
      "index.html",
      schedules: group_schedule_by_dates(schedule)
    )
  end
end
