defmodule IncidentReport.Factory do
  use ExMachina.Ecto, repo: IncidentReport.Repo

  def country_factory do
    %IncidentReport.Schema.Country{
      name: "United States",
      phone_code: "1",
      code: "US"
    }
  end

  def incident_factory do
    country = insert(:country, %{})

    %IncidentReport.Schema.Incident{
      name: "Mostafa Mohamed",
      relation: "Father",
      email: "mostafa@mail.com",
      phone_number: "phone_number",
      image_url: "URL",
      activation_status: "inactive",
      country_id: country.id,
      country: country,
      notes: "some notes",
      status: "ready",
      is_verified: false,
      number_processed: 0,
      local_image_path: Ecto.UUID.generate(),
      identifier: Ecto.UUID.generate()
    }
  end

  def incident_notification_factory do
    country = insert(:country, %{})

    %IncidentReport.Schema.IncidentNotification{
      name: "Mostafa Mohamed",
      email: "mostafa@mail.com",
      phone_number: "phone_number",
      image_url: "URL",
      country_id: country.id,
      notes: "some notes",
      is_verified: false,
      city: "Irving",
      district: "district",
      nearest_landmark: "nearesr landmark"
    }
  end
end
