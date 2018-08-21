defmodule Fawkes.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :slug, :string
      add :name, :string
      add :slot_id, references(:schedule_slots, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:events, [:slug])
    create index(:events, [:slot_id])
  end
end
