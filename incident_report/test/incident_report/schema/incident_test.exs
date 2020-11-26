defmodule IncidentReport.Schema.IncidentTest do
  use ExUnit.Case, async: false
  use IncidentReportWeb.ConnCase
  import IncidentReport.Factory
  alias IncidentReport.Schema.Incident

  describe "changeset" do
    test "has erros when name is missing" do
      country = insert(:country, %{})

      params = %{
        relation: "Father",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes"
      }

      changeset = Incident.changeset(%Incident{}, params)
      refute changeset.valid?

      assert changeset.errors |> List.first() ==
               {:name, {"can't be blank", [validation: :required]}}
    end

    test "has errors when local image path is missing" do
      country = insert(:country, %{})

      params = %{
        relation: "Father",
        name: "Mostafa Mohamed",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        country_id: country.id,
        notes: "some notes"
      }

      changeset = Incident.changeset(%Incident{}, params)
      refute changeset.valid?

      assert changeset.errors |> List.first() ==
               {:local_image_path, {"can't be blank", [validation: :required]}}
    end

    test "has errors when status is invalid" do
      country = insert(:country, %{})

      params = %{
        name: "Mostafa Mohamed",
        relation: "Father",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes",
        status: "invalid-status"
      }

      changeset = Incident.changeset(%Incident{}, params)
      refute changeset.valid?

      assert changeset.errors |> List.first() ==
               {:status,
                {"is invalid",
                 [validation: :inclusion, enum: ["ready", "suspended", "finished", "processing"]]}}
    end

    test "valid changeset" do
      incident = insert(:incident)
      refute incident.is_verified
      assert incident.status == "ready"

      params = %{
        "is_verified" => true,
        "name" => "other name",
        "status" => "suspended"
      }

      changeset = Incident.changeset(incident, params)
      assert changeset.changes.status == "suspended"
      assert changeset.changes.name == "other name"
      assert changeset.changes.is_verified
    end

    test "has errors changing exisiting changeset with invalid status" do
      incident = insert(:incident)
      assert incident.status == "ready"

      params = %{
        "status" => "invalid"
      }

      changeset = Incident.changeset(incident, params)
      assert changeset.errors |> List.first() ==
               {:status,
                {"is invalid",
                 [validation: :inclusion, enum: ["ready", "suspended", "finished", "processing"]]}}
    end
  end
end
