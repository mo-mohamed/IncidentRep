defmodule IncidentReport.Service.IncidentNotification do
  use IncidentReport.DAL.CommonQueries, schema_module: IncidentReport.Schema.IncidentNotification
  alias IncidentReport.Service.LocalFilehandler

  def receive(params) do
    IncidentReport.Repo.transaction(fn ->
      {:ok, file_name} = LocalFilehandler.save_file_from_upload(params["file"])
      country = IncidentReport.Service.Country.find_by(name: params["country"]) |> List.first()
      params =
        Map.put(params, "local_image_path", file_name)
        |> Map.put("country_id", country.id)
        |> Map.drop(["status", "is_verified", "identifier", "number_processed"])
        |> Map.put("identifier", Ecto.UUID.generate)

      {:ok, incident_notification} = create(params)
      IncidentReport.Mailer.IncidentNotification.send_incident_notification_received(incident_notification)
      incident_notification
    end)
  end
end
