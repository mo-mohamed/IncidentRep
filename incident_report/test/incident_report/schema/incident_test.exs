defmodule IncidentReport.Schema.IncidentTest do
  use IncidentReportWeb.ConnCase
  import IncidentReport.Factory
  alias IncidentReport.Schema
  alias IncidentReport.Service.Incident

  describe "Create" do
    test "returns error when name is missing" do
      country = insert(:country, %{})

      incident_params = %{
        relation: "Father",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Incident.create(incident_params)
      refute changeset.valid?

      assert changeset.errors |> List.first() ==
               {:name, {"can't be blank", [validation: :required]}}
    end

    # test "returns error when image_url is missing" do
    #   country = insert(:country, %{})

    #   incident_params = %{
    #     relation: "Father",
    #     name: "Mostafa Mohamed",
    #     email: "mostafa@mail.com",
    #     phone_number: "phone_number",
    #     country_id: country.id,
    #     notes: "some notes"
    #   }

    #   changeset = Incident.changeset(incident_params)
    #   refute changeset.valid?

    #   assert changeset.errors |> List.first() ==
    #            {:image_url, {"can't be blank", [validation: :required]}}
    # end

    test "returns invalid changeset for invalid status" do
      country = insert(:country, %{})

      incident_params = %{
        name: "Mostafa Mohamed",
        relation: "Father",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes",
        status: "invalid-status"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Incident.create(incident_params)
      refute changeset.valid?

      assert changeset.errors |> List.first() ==
               {:status,
                {"is invalid",
                 [validation: :inclusion, enum: ["ready", "suspended", "finished", "processing"]]}}
    end
  end

  describe "Update" do
    test "successful update" do
      incident = insert(:incident)
      refute incident.is_verified
      assert incident.status == "ready"

      update_params = %{
        "is_verified" => true,
        "name" => "other name",
        "status" => "suspended"
      }

      assert {:ok, incident_updated} = Incident.update(incident, update_params)
      assert incident_updated.status == "suspended"
      assert incident_updated.name == "other name"
      assert incident_updated.is_verified
    end

    test "returns error when status is invalid" do
      incident = insert(:incident)
      assert incident.status == "ready"

      update_params = %{
        "status" => "invalid"
      }

      assert {:error, changeset} = Incident.update(incident, update_params)

      assert changeset.errors |> List.first() ==
               {:status,
                {"is invalid",
                 [validation: :inclusion, enum: ["ready", "suspended", "finished", "processing"]]}}
    end

    # test "returns error when setting image url to null" do
    #   incident = insert(:incident)
    #   assert incident.status == "ready"

    #   update_params = %{
    #     "image_url" => nil
    #   }

    #   assert {:error, changeset} = Incident.update(incident, update_params)

    #   assert changeset.errors |> List.first() ==
    #            {:image_url, {"can't be blank", [validation: :required]}}
    # end
  end
end
