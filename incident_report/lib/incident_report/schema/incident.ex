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
    :status
  ]

  @required_attributes_create [
    :name,
    :email,
    :phone_number,
    :image_url,
    :status,
    :country_id,
    :status
  ]

  schema "incident" do
    field :name, :string
    field :relation, :string
    field :email, :string
    field :phone_number, :string
    field :image_url, :string
    field :is_verified, :boolean, default: false
    field :notes, :string
    field :status, IncidentStatus, default: "ready"
    field :number_processed, :integer, default: 0
    field :identifier, :binary_id, default: Ecto.UUID.generate()
    belongs_to(:country, IncidentReport.Schema.Country)
    timestamps()
  end

  @doc false
  def changeset(incident, attrs) do
    IO.inspect(incident, label: "inc")
    IO.inspect(attrs, label: "attrs")
    incident
    |> cast(attrs, @all_attributes_create)
    |> validate_required(@required_attributes_create)
    |> foreign_key_constraint(:country_id)
    |> validate_length(:name, max: 50, message: "name should be max of 50 characters")
    |> validate_length(:relation, max: 20, message: "relation should be max of 20 characters")
    |> validate_length(:phone_number, max: 20, message: "city should be max of 20 characters")
    |> validate_length(:image_url, max: 500, message: "state should be max of 500 characters")
    |> validate_length(:notes, max: 500, message: "notes should be max of 500 characters")
    |> validate_length(:status, max: 500, message: "status should be max of 500 characters")
  end
end
