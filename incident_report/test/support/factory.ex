defmodule IncidentReport.Factory do
  use ExMachina.Ecto, repo: IncidentReport.Repo
  
  def country_factory do
    %IncidentReport.Schema.Country{
      name: "United States",
      phone_code: "1",
      code: "US",
    }
  end
end