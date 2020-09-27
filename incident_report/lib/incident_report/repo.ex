defmodule IncidentReport.Repo do
  use Ecto.Repo,
    otp_app: :incident_report,
    adapter: Ecto.Adapters.Postgres
end
