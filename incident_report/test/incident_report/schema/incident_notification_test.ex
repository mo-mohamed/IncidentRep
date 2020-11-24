defmodule IncidentReport.Schema.IncidentNotificationTest do
  use IncidentReportWeb.ConnCase
  import IncidentReport.Factory
  alias IncidentReport.Schema
  alias IncidentReport.Service.IncidentNotification

  describe "Create" do
    test "successful create" do
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

      assert {:ok, %Schema.IncidentNotification{} = incident_notification} =
               IncidentNotification.create(params)
    end

    test "returns error when name is missing" do
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

      assert {:error, changeset} = IncidentNotification.create(params)
      refute changeset.valid?

      assert assert changeset.errors |> List.first() ==
                      {:name, {"can't be blank", [validation: :required]}}
    end

    test "returns error when city is missing" do
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

      assert {:error, changeset} = IncidentNotification.create(params)
      refute changeset.valid?

      assert assert changeset.errors |> List.first() ==
                      {:city, {"can't be blank", [validation: :required]}}
    end

    test "returns error when nearest landmark is missing" do
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

      assert {:error, changeset} = IncidentNotification.create(params)
      refute changeset.valid?

      assert assert changeset.errors |> List.first() ==
                      {:nearest_landmark, {"can't be blank", [validation: :required]}}
    end

    test "returns error when image_url is missing" do
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

      assert {:error, changeset} = IncidentNotification.create(params)
      refute changeset.valid?

      assert assert changeset.errors |> List.first() ==
                      {:image_url, {"can't be blank", [validation: :required]}}
    end
  end

  describe "Update" do
    test "successful update" do
      incident_notification = insert(:incident_notification)

      params = %{
        phone_number: "phone_number2",
        district: "some district2",
        city: "city2"
      }

      assert {:ok, incident_updated} = IncidentNotification.update(incident_notification, params)
      assert incident_updated.phone_number == "phone_number2"
      assert incident_updated.district == "some district2"
      assert incident_updated.city == "city2"
    end

    test "returns error when city is empty" do
      incident_notification = insert(:incident_notification)

      params = %{
        email: "mostafa@mail.com",
        phone_number: "phone_number2",
        image_url: "URL",
        district: "some district2",
        city: nil
      }

      assert {:error, changeset} = IncidentNotification.update(incident_notification, params)

      assert changeset.errors |> List.first() ==
               {:city, {"can't be blank", [validation: :required]}}
    end

    test "returns error when nearest landmark is empty" do
      incident_notification = insert(:incident_notification)

      params = %{
        email: "mostafa@mail.com",
        phone_number: "phone_number2",
        image_url: "URL",
        district: "some district2",
        city: "city",
        nearest_landmark: nil
      }

      assert {:error, changeset} = IncidentNotification.update(incident_notification, params)

      assert changeset.errors |> List.first() ==
               {:nearest_landmark, {"can't be blank", [validation: :required]}}
    end

    test "returns error when image url landmark is empty" do
      incident_notification = insert(:incident_notification)

      params = %{
        phone_number: "phone_number2",
        image_url: nil,
        district: "some district2"
      }

      assert {:error, changeset} = IncidentNotification.update(incident_notification, params)

      assert changeset.errors |> List.first() ==
               {:image_url, {"can't be blank", [validation: :required]}}
    end
  end
end
