defmodule IncidentReport.Factory do
  use ExMachina.Ecto, repo: IncidentReport.Repo
  
  def country_factory do
    %IncidentReport.Schema.Country{
      name: "United States",
      phone_code: "1",
      code: "US",
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
       country_id: country.id,
       notes: "some notes",
       status: "ready",
       is_verified: false,
       number_processed: 0
    }
  end
end