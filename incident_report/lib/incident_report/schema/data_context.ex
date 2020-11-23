defmodule IncidentReport.DAL.Context do
  alias IncidentReport.Repo
  alias IncidentReport.Schema.Country
  alias IncidentReport.Schema.Incident
  alias IncidentReport.Schema.IncidentReport
  use EctoResource

  using_repo(Repo) do
    #resource(Country)
    resource(Incident)
    resource(IncidentReport)
  end

end
