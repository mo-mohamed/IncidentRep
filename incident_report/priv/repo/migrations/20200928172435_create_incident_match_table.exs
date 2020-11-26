defmodule IncidentReport.Repo.Migrations.CreateIncidentMatchTable do
  use Ecto.Migration

  def up do
    create table(:incident_match, primary_key: false) do
      add(:id, :bigserial, null: false, primary_key: true)
      add(:incident_id, references(:incident, on_delete: :nothing), null: false)

      add(:incident_notification_id, references(:incident_notification, on_delete: :nothing),
        null: false
      )

      add(:confident_level, :float)
      timestamps()
    end
  end

  def down do
    drop(table(:incident_match))
  end
end
