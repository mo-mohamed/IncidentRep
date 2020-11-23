defmodule IncidentReport.Service.IncidentNotification do
  alias IncidentReport.DAL.Context, as: DBContext

  def all, do: DBContext.all_incident_notifications()
  def all(params), do: DBContext.all_incident_notifications(params)

  def changeset(struct, params),
    do: IncidentReport.Schema.IncidentNotification.changeset(struct, params)

  def create(params), do: DBContext.create_incident_notification(params)
  def create!(params), do: DBContext.create_incident_notification!(params)

  def delete(params), do: DBContext.delete_incident_notification(params)
  def delete!(params), do: DBContext.delete_incident_notification!(params)

  def get(params), do: DBContext.get_incident_notification(params)
  def get!(params), do: DBContext.get_incident_notification!(params)

  def update(struct, params), do: DBContext.update_incident_notification(struct, params)
  def update!(struct, params), do: DBContext.update_incident_notification!(struct, params)
end
