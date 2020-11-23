defmodule IncidentReport.Schema.IncidentReport do

    use Ecto.Schema
    import Ecto.Changeset
    import EctoEnum
    @primary_key {:id, :id, autogenerate: true}
    @timestamps_opts [type: :utc_datetime]
    @foreign_key_type :id

     @all_attributes_create [
      :name,
      :email,
      :phone_number,
      :image_url,
      :notes,
      :status,
      :country_id,
      :city,
      :district,
      :nearest_landmark
    ]

    schema "incident_report" do
      field :name, :string
      field :email, :string
      field :phone_number, :string
      field :image_url, :string
      field :is_verified, :boolean, default: false
      field :notes, :string
      field :city, :string
      field :district, :string
      field :nearest_landmark, :string
      field :identifier, :binary_id, default: Ecto.UUID.generate()
      belongs_to(:country, IncidentReport.Schema.Country)
      timestamps()
    end

    @doc false
    def changeset(incident, attrs) do
      incident
      |> cast(attrs, @all_attributes_create)
      |> foreign_key_constraint(:country_id)
      |> validate_length(:name, max: 50, message: "name should be max of 50 characters")
      |> validate_length(:phone_number, max: 20, message: "city should be max of 20 characters")
      |> validate_length(:image_url, max: 500, message: "state should be max of 500 characters")
      |> validate_length(:notes, max: 500, message: "notes should be max of 500 characters")
    end
  end
