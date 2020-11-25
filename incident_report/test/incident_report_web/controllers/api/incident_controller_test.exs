defmodule IncidentReportWeb.Api.IncidentControllerTest do
  use IncidentReportWeb.ConnCase
  use ExUnit.Case
  import IncidentReport.Factory
  import Mock
  alias IncidentReport.Service.Incident


  describe "POST /" do

    test "successful request with valid params", %{conn: conn} do
      country = insert(:country)
      params = %{
        "country" => country.name,
        "file" => %Plug.Upload{filename: "incident.jpeg", path: Path.join(File.cwd!(),  "/test/fixtures/incidents/incident.jpeg")},
        "name" => "Mostafa Mohamed",
        "phone_number" => "012345678",
        "email" => "mm@mail.com"
      }

      with_mock(IncidentReport.Mailer.Incident, [send_incident_received: fn _ -> :ok end])do
        conn = post(conn, "/api/incident/", params)
        assert json_response(conn, 200)
      end
    end

    test "returns error when  required params are missing (name, email, country, file, phone_number)", %{conn: conn} do
      country = insert(:country)
      params = %{
        "notes" => "my child"
      }

      with_mock(IncidentReport.Mailer.Incident, [send_incident_received: fn _ -> :ok end])do
        conn = post(conn, "/api/incident/", params)
        assert response = json_response(conn, 400)
        assert response["errors"]["name"] == ["can't be blank"]
        assert response["errors"]["country"] == ["can't be blank"]
        assert response["errors"]["file"] == ["image is required"]
        assert response["errors"]["phone_number"] == ["can't be blank"]
        assert response["errors"]["email"] == ["can't be blank"]
      end
    end

  end
end
