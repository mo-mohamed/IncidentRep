defmodule IncidentReport.Service.IncidentDisregard do
  alias IncidentReport.DAL.Context, as: DBContext
  def all, do: DBContext.all_incident_disregards()
  def all(params), do: DBContext.all_incident_disregards(params)
  def create(params), do: DBContext.create_incident_disregard(params)
  def create!(params), do: DBContext.create_incident_disregard!(params)

  def delete(params), do: DBContext.delete_incident_disregard(params)
  def delete!(params), do: DBContext.delete_incident_disregard!(params)

  def get(params), do: DBContext.get_incident_disregard(params)
  def get!(params), do: DBContext.get_incident_disregard!(params)

  def update(struct, params), do: DBContext.update_incident_disregard(struct, params)
  def update!(struct, params), do: DBContext.update_incident_disregard!(struct, params)
end
