defmodule FawkesWeb.SharedView do
  use FawkesWeb, :view
  alias Fawkes.Schedule.Slot
  alias FawkesWeb.SharedView

  @spec display_time(NaiveDateTime.t()) :: String.t()
  @spec employment(String.t() | nil, String.t() | nil) :: String.t() | nil
  @spec render_timespan(Slot.t()) :: map

  @doc """
  Given a datetime feturns the formatted time
  """
  def display_time(time), do: Timex.format!(time, "%l:%M %P", :strftime)

  @doc """
  Returns a formatted string of a given profile title and company values
  """
  def employment(title, company) do
    cond do
      is_nil(title) and is_nil(company) -> nil
      is_nil(company) -> company
      is_nil(title) -> title
      true -> "#{title} at #{company}"
    end
  end

  @doc """
  Given a slot returns a Slot.t returns a map of formatted date content
  """
  def render_timespan(%Slot{start: _, finish: _} = slot_info) do
    SharedView.render("time_span.html", _display_time_params(slot_info))
  end

  @spec _display_time_params(Slot.t()) :: map
  defp _display_time_params(%Slot{start: start, finish: finish}) do
    %{
      start_datetime: formal_datetime(start),
      start_time: display_time(start),
      finish_datetime: formal_datetime(finish),
      finish_time: display_time(finish)
    }
  end

  @spec formal_datetime(NaiveDateTime.t()) :: String.t()
  defp formal_datetime(date) do
    Timex.format!(date, "%Y-%m-%dT%H:%M", :strftime)
  end
end
