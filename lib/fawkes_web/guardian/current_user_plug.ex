defmodule FawkesWeb.Guardian.CurrentUserPlug do
  @moduledoc """
  Plug that populates the current_user assigns
  """

  alias FawkesWeb.Guardian.Tokenizer.Plug, as: GuardianPlug
  alias Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    Conn.assign(conn, :current_user, GuardianPlug.current_resource(conn))
  end
end
