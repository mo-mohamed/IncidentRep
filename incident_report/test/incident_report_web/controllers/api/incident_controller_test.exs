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
        assert response = json_response(conn, 200)
        assert is_bitstring(response["id"])
        assert response["email"]  == params["email"]
        assert response["notes"] == params["notes"]
        assert response["phone_number"] == params["phone_number"]
        assert response["country"] == country.name

        incident = Incident.find_by(identifier: response["id"]) |> List.first()
        assert incident.status == "ready"
        assert incident.is_verified == false
        assert incident.number_processed == 0
        assert is_bitstring(incident.local_image_path)
      end
    end

    test "returns error when  required params are missing (name, email, country, file, phone_number)", %{conn: conn} do
      country = insert(:country)
      params = %{
       notes: "my notes"
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

  describe "GET /" do

    test "activate incident", %{conn: conn} do
      incident = insert(:incident)
      refute incident.is_verified
      params_encoded = %{"email" => incident.email, "identifier" => incident.identifier} |> URI.encode_query()


      with_mock(IncidentReport.Mailer.Incident, [send_incident_activated: fn _ -> :ok end])do
        conn = get(conn, "/api/incident/activate?#{params_encoded}")
        assert response = json_response(conn, 200)

      end
    end

  end


  # describe "full cycle / " do
  #   test "submit an incident and verify via URL sent in email", %{conn: conn} do
  #     country = insert(:country)
  #     params = %{
  #       "notes" => "my child"
  #     }

  #     with_mock(IncidentReport.Mailer.Incident, [send_incident_received: fn _ -> :ok end])do
  #       conn = post(conn, "/api/incident/", params)
  #       assert response = json_response(conn, 400)
  #       assert response["errors"]["name"] == ["can't be blank"]
  #       assert response["errors"]["country"] == ["can't be blank"]
  #       assert response["errors"]["file"] == ["image is required"]
  #       assert response["errors"]["phone_number"] == ["can't be blank"]
  #       assert response["errors"]["email"] == ["can't be blank"]
  #     end

  # end


end
