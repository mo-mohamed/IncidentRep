defmodule IncidentReport.Service.IncidentMatch do
  alias IncidentReport.DAL.Context, as: DBContext
  def all, do: DBContext.all_incident_matches()
  def all(params), do: DBContext.all_incident_matches(params)
  def create(params), do: DBContext.create_incident_match(params)
  def create!(params), do: DBContext.create_incident_match!(params)

  def delete(params), do: DBContext.delete_incident_match(params)
  def delete!(params), do: DBContext.delete_incident_match!(params)

  def get(params), do: DBContext.get_incident_match(params)
  def get!(params), do: DBContext.get_incident_match!(params)

  def update(struct, params), do: DBContext.update_incident_match(struct, params)
  def update!(struct, params), do: DBContext.update_incident_match!(struct, params)
end
