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
        "file" => %Plug.Upload{filename: "incident.jpeg", path: "/test/fixtures/incident.jpeg"},
        "name" => "Mostafa Mohamed",
        "phone_number" => "012345678",
        "email" => "mm@mail.com"
      }

      with_mock(IncidentReport.Mailer.Incident, [send_incident_received: fn _ -> :ok end])do
        conn = post(conn, "/api/incident/", params)
        assert json_response(conn, 200)
      end

    end
  end

end
