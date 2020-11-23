defmodule IncidentReport.Service.Incident do
  alias IncidentReport.DAL.Context, as: DBContext

  def all, do: DBContext.all_incidents()
  def all(params), do: DBContext.all_incidents(params)

  def changeset(struct, params), do: IncidentReport.Schema.Incident.changeset(struct, params)

  def create(params), do: DBContext.create_incident(params)
  def create!(params), do: DBContext.create_incident!(params)

  def delete(params), do: DBContext.delete_incident(params)
  def delete!(params), do: DBContext.delete_incident!(params)

  def get(params), do: DBContext.get_incident(params)
  def get!(params), do: DBContext.get_incident!(params)

  def update(struct, params), do: DBContext.update_incident(struct, params)
  def update!(struct, params), do: DBContext.update_incident!(struct, params)





end
