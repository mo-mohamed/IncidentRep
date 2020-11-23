defmodule IncidentReport.Repo.Migrations.AddFilPathIncident do
  use Ecto.Migration

  def up do
    alter table("incident") do
      add(:local_image_path, :text, null: false)
    end
  end

  def down do
    alter table("incident") do
      remove :local_image_path
    end
  end
end
