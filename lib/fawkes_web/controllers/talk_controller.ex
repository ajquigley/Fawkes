defmodule FawkesWeb.TalkController do
  use FawkesWeb, :controller

  def show(conn, %{"id" => slug}) do
    render(conn, "show.html", talk: Schedule.fetch_talks(slug))
  end
end
