defmodule FawkesWeb.PageController do
  use FawkesWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
