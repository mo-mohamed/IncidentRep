defmodule IncidentReport.Schema.IncidentDisregard do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime]

  alias IncidentReport.Schema.{Incident, IncidentReport}

  @all_attributes [
    :reason
  ]

  schema "incident_disregard" do
    field :reason, :string
    belongs_to(:incident, Incident)
    belongs_to(:incident_reports, IncidentReport)
    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, @all_attributes)
    |> validate_required(@all_attributes)
    |> validate_inclusion(:reason, IncidentReportTypes.incident_disregard_reason())
  end
end
