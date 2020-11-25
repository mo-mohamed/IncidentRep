
defmodule IncidentReport.Mailer do
  use Swoosh.Mailer, otp_app: :incident_report
end

defmodule IncidentReport.Mailer.Incident do
  use Phoenix.Swoosh, view: IncidentReportWeb.EmailView, layout: {IncidentReportWeb.EmailView, :layout}
  alias Swoosh.Email

  def send_incident_received(incident) do
    base_url = IncidentReportWeb.Endpoint.url()
    params_encoded = %{"email" => incident.email, "identifier" => incident.identifier} |> URI.encode_query()
    activation_link = "#{base_url}/api/incident/activate?#{params_encoded}"

    %Email{}
    |> from("mostafa.a.mohamed90@gmail.com")
    |> to(incident.email)
    |> subject("Incident Received - Verification Required")
    |> render_body("incident_received.html", %{name: incident.name, link: activation_link})
    |> IncidentReport.Mailer.deliver()
  end
end
