defmodule IncidentReport.Schema.Country do

  use Ecto.Schema
  @primary_key {:id, :id, autogenerate: true} 
  @timestamps_opts [type: :utc_datetime]

  alias IncidentReport.Schema.{Incident}
  schema "country" do
    field :name, :string
    field :code, :string
    field :phone_code, :string
    has_many(:incidents, Incident, on_delete: :delete_all)
    timestamps()
  end
end