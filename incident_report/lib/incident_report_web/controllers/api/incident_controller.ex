defmodule IncidentReportWeb.Api.IncidentController do
  use IncidentReportWeb, :controller
  alias IncidentReportWeb.Api.ErrorView
  alias IncidentReport.Service.Incident
  alias IncidentReportWeb.Validations.Api.Incident.Create, as: IncidentParamsValidation

  def create(conn, params) do
    paramaters_changset = param_validations(IncidentParamsValidation, [%IncidentParamsValidation{}, params])

    if paramaters_changset.valid? == false do
      error_views(conn, 400, changeset: paramaters_changset)
    else
      case Incident.receive(params) do
        {:ok, _incident} ->
          conn
          |> put_status(:ok)
          |> json("Thank you, your incident has been saved")

        {:error, %Ecto.Changeset{} = changeset} ->
          error_views(conn, 400, changeset: changeset)

        {:error, error} ->
          error_views(conn, 400, error: error)
      end
    end
  end

  def activate(conn, params) do
    case Incident.activate(params) do
      {:error, _} -> Plug.Conn.send_resp(conn, 400, "Incident already activated or not found")
      {:ok, _} -> Plug.Conn.send_resp(conn, 200, "")
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
