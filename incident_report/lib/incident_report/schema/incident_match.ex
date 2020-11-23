defmodule IncidentReport.Schema.IncidentMatch do
  use Ecto.Schema
  @primary_key {:id, :id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime]

  alias IncidentReport.Schema.{Incident, IncidentReport}

  schema "incident_match" do
    field :confident_level, :float
    belongs_to(:incident, Incident)
    belongs_to(:incident_reports, IncidentReport)
    timestamps()
  end
end
