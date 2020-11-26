defmodule IncidentReport.Schema.IncidentNotificationTest do
  use ExUnit.Case, async: false
  use IncidentReportWeb.ConnCase
  import IncidentReport.Factory
  alias IncidentReport.Schema.IncidentNotification

  describe "changeset" do
    test "valid changeset for valid params" do
      country = insert(:country, %{})

      params = %{
        name: "Mostafa Mohamed",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes",
        district: "some district",
        city: "city",
        nearest_landmark: "play ground"
      }

      changeset = IncidentNotification.changeset(%IncidentNotification{}, params)
      assert changeset.valid?
    end

    test "has errors when name is missing" do
      country = insert(:country, %{})

      params = %{
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes",
        district: "some district",
        city: "city",
        nearest_landmark: "play ground"
      }

      changeset = IncidentNotification.changeset(%IncidentNotification{}, params)
      refute changeset.valid?

      assert assert changeset.errors |> List.first() ==
                      {:name, {"can't be blank", [validation: :required]}}
    end

    test "has errors when city is missing" do
      country = insert(:country, %{})

      params = %{
        name: "Mostafa Mohamed",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes",
        district: "some district",
        nearest_landmark: "play ground"
      }

      changeset = IncidentNotification.changeset(%IncidentNotification{}, params)
      refute changeset.valid?
      assert assert changeset.errors |> List.first() ==
                      {:city, {"can't be blank", [validation: :required]}}
    end

    test "has errors when nearest_landmark is missing" do
      country = insert(:country, %{})

      params = %{
        name: "Mostafa Mohamed",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: "URL",
        country_id: country.id,
        notes: "some notes",
        district: "some district",
        city: "city"
      }

      changeset = IncidentNotification.changeset(%IncidentNotification{}, params)
      refute changeset.valid?
      assert assert changeset.errors |> List.first() ==
                      {:nearest_landmark, {"can't be blank", [validation: :required]}}
    end

    test "has errors when image_url is missing" do
      country = insert(:country, %{})

      params = %{
        name: "Mostafa Mohamed",
        email: "mostafa@mail.com",
        phone_number: "phone_number",
        image_url: nil,
        country_id: country.id,
        notes: "some notes",
        district: "some district",
        city: "city",
        nearest_landmark: "play ground"
      }

      changeset = IncidentNotification.changeset(%IncidentNotification{}, params)
      refute changeset.valid?
      assert assert changeset.errors |> List.first() ==
                      {:image_url, {"can't be blank", [validation: :required]}}
    end

    test "success changes againts an already structed struct" do
      incident_notification = insert(:incident_notification)

      params = %{
        phone_number: "phone_number2",
        district: "some district2",
        city: "city2"
      }

      changeset = IncidentNotification.changeset(incident_notification, params)
      assert changeset.valid?
      assert changeset.changes.phone_number == "phone_number2"
      assert changeset.changes.district == "some district2"
      assert changeset.changes.city == "city2"
    end

    test "has errors when city is missing for updating a changeset" do
      incident_notification = insert(:incident_notification)

      params = %{
        email: "mostafa@mail.com",
        phone_number: "phone_number2",
        image_url: "URL",
        district: "some district2",
        city: nil
      }

      changeset = IncidentNotification.changeset(incident_notification, params)
      refute changeset.valid?
      assert changeset.errors |> List.first() ==
               {:city, {"can't be blank", [validation: :required]}}
    end

    test "has errors when nearest_landmark is missing for updating a changeset" do
      incident_notification = insert(:incident_notification)

      params = %{
        email: "mostafa@mail.com",
        phone_number: "phone_number2",
        image_url: "URL",
        district: "some district2",
        city: "city",
        nearest_landmark: nil
      }

      changeset = IncidentNotification.changeset(incident_notification, params)
      refute changeset.valid?
      assert changeset.errors |> List.first() ==
               {:nearest_landmark, {"can't be blank", [validation: :required]}}
    end

    test "has errors when image_url is missing for updating a changeset" do
      incident_notification = insert(:incident_notification)

      params = %{
        phone_number: "phone_number2",
        image_url: nil,
        district: "some district2"
      }

      changeset = IncidentNotification.changeset(incident_notification, params)
      refute changeset.valid?
      assert changeset.errors |> List.first() ==
               {:image_url, {"can't be blank", [validation: :required]}}
    end
  end
end
