defmodule IncidentReportWeb.Api.IncidentNotificationControllerTest do
  use IncidentReportWeb.ConnCase
  use ExUnit.Case

  import IncidentReport.Factory
  import Mock

  alias IncidentReport.Service.IncidentNotification



  describe "POST /" do
    test "successful request with valid params", %{conn: conn} do
      country = insert(:country)
      params = %{
        "country" => country.name,
        "file" => %Plug.Upload{filename: "incident.jpeg", path: Path.join(File.cwd!(),  "/test/fixtures/incidents/incident.jpeg")},
        "name" => "Mostafa Mohamed",
        "phone_number" => "012345678",
        "email" => "mm@mail.com",
        "city" => "some city",
        "district" => "some district",
        "nearest_landmark" => "play ground",
        "notes" => "some notes"
      }

      with_mock(IncidentReport.Mailer.IncidentNotification, [send_incident_notification_received: fn _ -> :ok end])do
        conn = post(conn, "/api/incident_notification/", params)
        assert response = json_response(conn, 200)
        assert is_bitstring(response["id"])
        assert response["email"]  == params["email"]
        assert response["phone_number"] == params["phone_number"]
        assert response["country"] == country.name
        assert response["notes"] == params["notes"]
        assert response["nearest_landmark"] == params["nearest_landmark"]
        assert response["district"] == params["district"]
        assert response["city"] == params["city"]

        incident_notification = IncidentNotification.find_by([identifier: response["id"]], preloads: [:country]) |> List.first()
        assert is_bitstring(incident_notification.local_image_path)
      end
    end

    test "returns error when  required params are missing (name, email, country, file, phone_number)", %{conn: conn} do
      params = %{"notes" => "my notes"}

      with_mock(IncidentReport.Mailer.IncidentNotification, [send_incident_notification_received: fn _ -> :ok end])do
        conn = post(conn, "/api/incident_notification/", params)
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
