defmodule IncidentReport.Service.Incident do
  use IncidentReport.DAL.CommonQueries, schema_module: IncidentReport.Schema.Incident
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
        |> Map.put("activation_status", "inactive")

      {:ok, incident} = create(params)
      IncidentReport.Mailer.Incident.send_incident_received(incident)
      incident
    end)
  end

  def activate(%{"email" => email, "identifier" => identifier} = _params) do
      incident = find_by([email: email, identifier: identifier], preloads: [:country]) |> List.first()
      case incident do
        nil -> {:error, :not_found}
        _ -> activate_incident(incident)
      end
  end

  defp activate_incident(incident) do
    case incident.is_verified do
      true -> {:error, :already_active}
      false ->
        {:ok, incident} = update(incident, %{is_verified: true, activation_status: "active"})
        IncidentReport.Mailer.Incident.send_incident_activated(incident)
        {:ok, incident}
    end
  end
end
