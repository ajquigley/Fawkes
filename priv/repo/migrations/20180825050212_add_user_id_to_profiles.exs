defmodule Fawkes.Repo.Migrations.AddUserIdToProfiles do
  use Ecto.Migration

  def change do
    alter table("profiles") do
      add :user_id, references("users")
    end
  end
end
