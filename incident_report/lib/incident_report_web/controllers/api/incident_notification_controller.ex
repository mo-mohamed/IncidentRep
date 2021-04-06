defmodule IncidentReportWeb.Api.IncidentNotificationController do
  use IncidentReportWeb, :controller
  alias IncidentReportWeb.Api.{IncidentNotificationView, ErrorView}
  alias IncidentReport.Service.IncidentNotification
  alias IncidentReportWeb.Validations.Api.IncidentNotification.Create, as: IncidentNotificationParamsValidation

  def create(conn, params) do
    paramaters_changset = param_validations(IncidentNotificationParamsValidation, [%IncidentNotificationParamsValidation{}, params])

    if paramaters_changset.valid? == false do
      error_views(conn, 400, changeset: paramaters_changset)
    else
      case IncidentNotification.receive(params) do
        {:ok, incident_notification} ->
          incident_notification = incident_notification |> IncidentReport.Repo.preload([:country])
          conn
          |> put_status(:ok)
          |> put_view(IncidentNotificationView)
          |> render("incident_received_activated.json", %{incident_notification: incident_notification, msg: "received"})

        {:error, %Ecto.Changeset{} = changeset} ->
          error_views(conn, 400, changeset: changeset)

        {:error, error} ->
          error_views(conn, 400, error: error)
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
