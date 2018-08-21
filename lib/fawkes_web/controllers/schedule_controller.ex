defmodule FawkesWeb.ScheduleController do
  use FawkesWeb, :controller
  import FawkesWeb.CalendarHelpers

  def index(conn, _params) do
    schedule = Schedule.fetch()

    render(conn, "index.html", schedules: group_schedule_by_dates(schedule))
  end

  def show(conn, %{"id" => slug}) do
    schedule = slug |> Schedule.fetch() |> List.wrap()

    render(conn, "index.html", schedules: group_schedule_by_dates(schedule))
  end
end
