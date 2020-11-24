defmodule IncidentReportWeb.Api.IncidentController do
  use IncidentReportWeb, :controller
  alias IncidentReportWeb.Api.ErrorView

  alias IncidentReport.Service.Incident
  alias IncidentReport.Service.LocalFilehandler
  alias IncidentReportWeb.Validations.Api.Incident.Create, as: IncidentParamsValidation

  def create(conn, params) do
    paramaters_changset =
      param_validations(IncidentParamsValidation, [%IncidentParamsValidation{}, params])
      |> IO.inspect(label: "validation")

    if paramaters_changset.valid? == false do
      error_views(conn, 400, changeset: paramaters_changset)
    else
      {:ok, file_name} = LocalFilehandler.save_file_from_upload(params["file"])

      params =
        Map.put(params, "local_image_path", file_name)
        |> Map.put("country_id", 3)
        |> Map.drop(["status", "is_verified", "identifier", "number_processed"])

      case Incident.create(params) |> IO.inspect(label: "validation222") do
        {:ok, incident} ->
          IncidentReport.Service.IncidentMail.incident_received(incident, "www.google.com") |> IncidentReport.Service.Mailer.deliver()
          conn
          |> put_status(:ok)
          |> json("Thank you, your incident has been saved")

        {:error, changeset} ->
          error_views(conn, 400, changeset: changeset)
      end
    end
  end

  defp param_validations(module, params) do
    apply(module, :changeset, params)
  end

  defp error_views(conn, status, params) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", params)
  end
end
