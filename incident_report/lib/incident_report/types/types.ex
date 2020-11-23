# import EctoEnum

# defenum(IncidentReportTypes.IncidentStatus,
#   ready: "ready",
#   suspended: "suspended",
#   finished: "finished",
#   processing: "processing"
# )

# defenum(IncidentReportTypes.IncidentDisregardReason, no_match: "no_match", low_match: "low_match")

defmodule IncidentReportTypes do
  def incident_status do
    ["ready", "suspended", "finished", "processing"]
  end

  def incident_disregard_reason do
    ["no_match", "low_match"]
  end
end
