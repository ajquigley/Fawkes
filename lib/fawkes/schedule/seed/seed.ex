defmodule Fawkes.Schedule.Seed do
  @moduledoc false

  alias Fawkes.Schedule.Seed.Audience
  alias Fawkes.Schedule.Seed.Category
  alias Fawkes.Schedule.Seed.Event
  alias Fawkes.Schedule.Seed.Location
  alias Fawkes.Schedule.Seed.Slot
  alias Fawkes.Schedule.Seed.Speaker
  alias Fawkes.Schedule.Seed.Talk

  def perform do
    Slot.perform()
    Speaker.perform()
    Location.perform()
    Category.perform()
    Audience.perform()
    Talk.perform()
    Event.perform()
  end
end
