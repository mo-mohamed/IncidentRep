defmodule IncidentReport.Service.Incident do
  use IncidentReport.DAL.CommonQueries, schema_module: IncidentReport.Schema.Incident
  alias IncidentReport.Service.LocalFilehandler

  def receive(params) do
    IncidentReport.Repo.transaction(fn ->
      {:ok, file_name} = LocalFilehandler.save_file_from_upload(params["file"])

      params =
        Map.put(params, "local_image_path", file_name)
        |> Map.put("country_id", 3)
        |> Map.drop(["status", "is_verified", "identifier", "number_processed"])

      {:ok, incident} = create(params)
      base_url = IncidentReportWeb.Endpoint.url()
      params_encoded = %{"email" => incident.email, "identifier" => incident.identifier} |> URI.encode_query()
      activation_link = "#{base_url}/api/incident/activate?#{params_encoded}"
      IncidentReport.Service.IncidentMail.incident_received(incident, activation_link) |> IncidentReport.Service.Mailer.deliver()

      incident
    end)
  end


  def activate(%{"email" => email, "identifier" => identifier} = _params) do
      incident = find_by([email: email, identifier: identifier]) |> List.first()
      case incident do
        nil -> {:error, :not_found}
        _ -> activate_incident(incident)
      end
  end

  defp activate_incident(incident) do
    case incident.is_verified do
      true -> {:error, :already_active}
      false -> update(incident, %{is_verified: true})
    end
  end
end
