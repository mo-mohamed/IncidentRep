defmodule IncidentReport.Service.IncidentReport do
  alias IncidentReport.DAL.Context, as: DBContext

  def all, do: DBContext.all_incident_reports()
  def all(params), do: DBContext.all_incident_reports(params)

  def changeset(struct, params),
    do: IncidentReport.Schema.IncidentReport.changeset(struct, params)

  def create(params), do: DBContext.create_incident_report(params)
  def create!(params), do: DBContext.create_incident_report!(params)

  def delete(params), do: DBContext.delete_incident_report(params)
  def delete!(params), do: DBContext.delete_incident_report!(params)

  def get(params), do: DBContext.get_incident_report(params)
  def get!(params), do: DBContext.get_incident_report!(params)

  def update(struct, params), do: DBContext.update_incident_report(struct, params)
  def update!(struct, params), do: DBContext.update_incident_report!(struct, params)
end
