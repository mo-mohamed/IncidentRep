defmodule IncidentReportWeb.Api.IncidentController do
  use IncidentReportWeb, :controller
  alias IncidentReportWeb.Api.{IncidentView, ErrorView}
  alias IncidentReport.Service.Incident
  alias IncidentReportWeb.Validations.Api.Incident.Create, as: IncidentParamsValidation

  def create(conn, params) do
    paramaters_changset = param_validations(IncidentParamsValidation, [%IncidentParamsValidation{}, params])

    if paramaters_changset.valid? == false do
      error_views(conn, 400, changeset: paramaters_changset)
    else
      case Incident.receive(params) do
        {:ok, incident} ->
          incident = incident |> IncidentReport.Repo.preload([:country])
          conn
          |> put_status(:ok)
          |> put_view(IncidentView)
          |> render("incident_received_activated.json", %{incident: incident, msg: "received and requires verification"})

        {:error, %Ecto.Changeset{} = changeset} ->
          error_views(conn, 400, changeset: changeset)

        {:error, error} ->
          error_views(conn, 400, error: error)
      end
    end
  end

  def activate(conn, params) do
    case Incident.activate(params) do
      {:error, :not_found} ->  error_views(conn, 404, %{errors: "not found"})
      {:error, :already_active} ->  error_views(conn, 400, %{errors: "already activated"})
      {:ok, incident} ->
      conn
      |> put_status(:ok)
      |> put_view(IncidentView)
      |> render("incident_received_activated.json", %{incident: incident, msg: "activated successfully"})
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
