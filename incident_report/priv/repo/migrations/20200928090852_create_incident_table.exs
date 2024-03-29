defmodule IncidentReport.Repo.Migrations.CreateIncidentTable do
  use Ecto.Migration

  def up do
    create table(:incident, primary_key: false) do
      add(:id, :bigserial, null: false, primary_key: true)
      add(:name, :string, null: false)
      add(:relation, :string)
      add(:email, :string, null: false)
      add(:phone_number, :string, null: false)
      add(:image_url, :string)
      add(:is_verified, :boolean, null: false, default: false)
      add(:notes, :string)
      add(:status, :string, null: false, default: "ready")
      add(:identifier, :string, null: false)
      add(:activation_status, :string, null: false)
      add(:number_processed, :integer, null: false, default: 0)
      add(:country_id, references(:country, on_delete: :nothing), null: false)
      timestamps()
    end
  end

  def down do
    drop(table(:incident))
  end
end
