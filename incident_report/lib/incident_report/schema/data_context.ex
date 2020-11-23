defmodule IncidentReport.DAL.Context do
  alias IncidentReport.Repo

  alias IncidentReport.Schema.{
    Country,
    Incident,
    IncidentReport,
    IncidentMatch,
    IncidentDisregard
  }

  use EctoResource

  using_repo(Repo) do
    # resource(Country)
    resource(Incident)
    resource(IncidentReport)
    resource(IncidentMatch)
    resource(IncidentDisregard)
  end
end
