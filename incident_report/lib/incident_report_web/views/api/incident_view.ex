defmodule IncidentReportWeb.Api.IncidentView do
  use IncidentReportWeb, :view

  def render("incident_received_activated.json", %{incident: incident, msg: msg}) do
    %{
      status: msg,
      id: incident.identifier,
      name: incident.name,
      relation: incident.relation,
      email: incident.email,
      phone_number: incident.phone_number,
      country: incident.country.name,
      notes: incident.notes
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
