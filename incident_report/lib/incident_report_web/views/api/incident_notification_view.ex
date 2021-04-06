defmodule IncidentReportWeb.Api.IncidentNotificationView do
  use IncidentReportWeb, :view

  def render("incident_received_activated.json", %{incident_notification: incident_notification, msg: msg}) do
    %{
      id: incident_notification.identifier,
      name: incident_notification.name,
      email: incident_notification.email,
      phone_number: incident_notification.phone_number,
      country: incident_notification.country.name,
      notes: incident_notification.notes,
      city: incident_notification.city,
      nearest_landmark: incident_notification.nearest_landmark,
      district: incident_notification.district,
      message: msg
    }
  end

  def render("show.json", %{incident: incident}) do
    %{
      id: incident.identifier,
      name: incident.name,
      relation: incident.relation,
      email: incident.email,
      phone_number: incident.phone_number,
      status: incident.status,
      verified: incident.is_verified,
      image_url: incident.image_url,
      local_path: incident.local_image_path,
      country: incident.country.name,
      notes: incident.notes
    }
  end
end
