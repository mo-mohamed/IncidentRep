defmodule IncidentReport.Repo.Migrations.CreateIncidentReportTable do
  use Ecto.Migration

  def up do
    create table(:incident_notification, primary_key: false) do
      add(:id, :bigserial, null: false, primary_key: true)
      add(:name, :string, null: false)
      add(:email, :string, null: false)
      add(:phone_number, :string, null: false)
      add(:city, :string)
      add(:district, :string)
      add(:nearest_landmark, :string)
      add(:image_url, :string)
      add(:identifier, :string, null: false)
      add(:is_verified, :boolean, null: false, default: false)
      add(:notes, :string)
      add(:local_image_path, :string, null: false)
      add(:country_id, references(:country, on_delete: :nothing), null: false)
      timestamps()
    end
  end

  def down do
    drop(table(:incident_notification))
  end
end
