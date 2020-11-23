defmodule IncidentReport.Repo.Migrations.CreateCountryTable do
  use Ecto.Migration

  def up do
    create table(:country, primary_key: false) do
      add(:id, :bigserial, null: false, primary_key: true)
      add(:name, :string, null: false)
      add(:code, :string, null: false)
      add(:phone_code, :string, null: false)
      timestamps()
    end

    create(unique_index(:country, [:name, :code, :phone_code]))
  end

  def down do
    drop(unique_index(:country, [:name, :code, :phone_code]))
    drop(table(:country))
  end
end
