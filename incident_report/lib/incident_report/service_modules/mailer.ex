
defmodule IncidentReport.Service.Mailer do
  use Swoosh.Mailer, otp_app: :incident_report
end

defmodule IncidentReport.Service.IncidentMail do
  use Phoenix.Swoosh, view: IncidentReportWeb.EmailView, layout: {IncidentReportWeb.EmailView, :layout}
  alias Swoosh.Email
  @spec incident_received(atom | %{email: any, name: any}, any) :: %{assigns: map, private: map}
  def incident_received(incident, activation_link) do
    %Email{}
    |> from("mostafa.a.mohamed90@gmail.com")
    |> to(incident.email)
    |> subject("Incident Received - Verification Required")
    |> render_body("incident_received.html", %{name: incident.name, link: activation_link})
  end
end
