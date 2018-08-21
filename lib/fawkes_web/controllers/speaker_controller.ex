defmodule FawkesWeb.SpeakerController do
  use FawkesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", speakers: Schedule.fetch_speakers())
  end

  def show(conn, %{"id" => slug}) do
    render(conn, "show.html", speaker: Schedule.fetch_speakers(slug))
  end
end
