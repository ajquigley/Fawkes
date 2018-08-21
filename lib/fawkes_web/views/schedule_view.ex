defmodule FawkesWeb.ScheduleView do
  use FawkesWeb, :view
  alias FawkesWeb.ScheduleView
  alias FawkesWeb.SharedView
  alias Fawkes.Schedule.Slot

  @spec render_slot(Slot.t(), map) :: iodata
  @spec talks_exist?(Slot.t()) :: boolean

  @doc """
  Given a slot and an assigns map returns a rendered partial
  """
  def render_slot(slot, assigns) do
    cond do
      talks_exist?(slot) -> render(ScheduleView, "talks.html", assigns)
      not is_nil(slot.event) -> render(ScheduleView, "event.html", assigns)
    end
  end

  @spec talks_exist?(Slot.t()) :: boolean
  defp talks_exist?(%{talks: [_ | _]}), do: true
  defp talks_exist?(_), do: false
end
