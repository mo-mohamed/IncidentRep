defmodule IncidentReport.Schema.IncidentTest do
  use IncidentReportWeb.ConnCase
  import IncidentReport.Factory

  test "changeset" do
   country = insert(:country, %{})
   incident_params = %{
       name: "Mostafa Mohamed",
       relation: "Father",
       email: "mostafa@mail.com",
       phone_number: "phone_number",
       image_url: "URL",
       country_id: country.id,
       notes: "some notes"
   }

   result = IncidentReport.Schema.Incident.changeset(%IncidentReport.Schema.Incident{}, incident_params) |> IncidentReport.Repo.insert()
   assert  {:ok, %IncidentReport.Schema.Incident{} = incident} = result
   # default values
   assert incident.status == "ready"
   assert incident.is_verified == false
   assert incident.number_processed == 0
   refute incident.identifier == nil
  end

  test "returns error when name is missing" do
    country = insert(:country, %{})
    incident_params = %{
        relation: "Father",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes"
    }
 
    assert {:error, %Ecto.Changeset{} = changeset} = IncidentReport.Schema.Incident.changeset(%IncidentReport.Schema.Incident{}, incident_params) |> IncidentReport.Repo.insert()
    assert changeset.errors |> List.first() == {:name, {"can't be blank", [validation: :required]}}
   end

   test "returns error when image_url is missing" do
    country = insert(:country, %{})
    incident_params = %{
        relation: "Father",
        name: "Mostafa Mohamed",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        country_id: country.id,
        notes: "some notes"
    }
 
    assert {:error, %Ecto.Changeset{} = changeset} = IncidentReport.Schema.Incident.changeset(%IncidentReport.Schema.Incident{}, incident_params) |> IncidentReport.Repo.insert()
    assert changeset.errors |> List.first() == {:image_url, {"can't be blank", [validation: :required]}}
   end

  test "returns invalid changeset for invalid status" do
   country = insert(:country, %{})
   incident_params = %{
       name: "Mostafa Mohamed",
       relation: "Father",
       email: "mostafa@mail.com",
       phone_number: "phone_number",
       image_url: "URL",
       country_id: country.id,
       notes: "some notes",
       status: "invalid-status"
   }

   changeset_result =  IncidentReport.Schema.Incident.changeset(%IncidentReport.Schema.Incident{}, incident_params)
   refute changeset_result.valid?
   assert changeset_result.errors |> List.first() == {:status, {"is invalid", [type: IncidentStatus, validation: :cast]}}
  end
end
