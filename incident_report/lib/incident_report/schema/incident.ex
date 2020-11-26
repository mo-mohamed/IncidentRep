defmodule IncidentReport.Schema.Incident do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime]
  @foreign_key_type :id

  @all_attributes_create [
    :name,
    :relation,
    :email,
    :phone_number,
    :image_url,
    :notes,
    :status,
    :country_id,
    :status,
    :is_verified,
    :local_image_path,
    :identifier,
    :activation_status
  ]

  @required_attributes_create [
    :name,
    :email,
    :phone_number,
    :status,
    :country_id,
    :status,
    :local_image_path,
    :identifier,
    :activation_status
  ]

  schema "incident" do
    field :name, :string
    field :relation, :string
    field :email, :string
    field :phone_number, :string
    field :image_url, :string
    field :is_verified, :boolean, default: false
    field :notes, :string
    field :status, :string, default: "ready"
    field :number_processed, :integer, default: 0
    field :local_image_path, :string
    field :identifier, :string
    field :activation_status, :string
    belongs_to(:country, IncidentReport.Schema.Country)
    timestamps()
  end

  @doc false
  def changeset(incident, attrs) do
    incident
    |> cast(attrs, @all_attributes_create)
    |> validate_required(@required_attributes_create)
    |> foreign_key_constraint(:country_id)
    |> validate_inclusion(:status, IncidentReportTypes.incident_status())
    |> validate_inclusion(:activation_status, IncidentReportTypes.incident_activation_status())
    |> validate_length(:name, max: 150, message: "name should be max of 150 characters")
    |> validate_length(:relation, max: 40, message: "relation should be max of 40 characters")
    |> validate_length(:phone_number, max: 40, message: "city should be max of 40 characters")
    |> validate_length(:image_url, max: 500, message: "state should be max of 500 characters")
    |> validate_length(:notes, max: 500, message: "notes should be max of 500 characters")
  end
end
