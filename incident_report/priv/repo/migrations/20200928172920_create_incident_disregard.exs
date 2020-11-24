defmodule IncidentReport.Repo.Migrations.CreateIncidentDisregard do
  use Ecto.Migration

  def up do
    create table(:incident_disregard, primary_key: false) do
      add(:id, :bigserial, null: false, primary_key: true)
      add(:incident_id, references(:incident, on_delete: :nothing), null: false)

      add(:incident_notification_id, references(:incident_notification, on_delete: :nothing),
        null: false
      )

      add(:disregard_reason, :string)
      timestamps()
    end
  end

  def down do
    drop(table(:incident_disregard))
  end
end
