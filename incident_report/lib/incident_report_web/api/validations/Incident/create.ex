defmodule IncidentReportWeb.Validations.Api.Incident.Create do
  use Ecto.Schema
  import Ecto.Changeset

  @all_attributes [
    :name,
    :relation,
    :email,
    :phone_number,
    :notes,
    :country
  ]

  @required_attributes [
    :name,
    :email,
    :phone_number,
    :country
  ]

  schema "incident_create_params" do
    field :name, :string
    field :relation, :string
    field :email, :string
    field :phone_number, :string
    field :notes, :string
    field :country, :string
  end

  @doc false
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, @all_attributes)
    |> validate_required(@required_attributes)
    |> validate_file_exists(attrs)
    |> validate_image_file_extension(attrs)
    |> validate_email(attrs)
  end

  defp validate_file_exists(changeset, %{"file" => %Plug.Upload{} = _file} = _attrs),
    do: changeset

  defp validate_file_exists(changeset, _attrs) do
    changeset
    |> Map.put(:valid?, false)
    |> add_error(:file, "image is required", [])
  end

  defp validate_image_file_extension(
         %{valid?: true} = changeset,
         %{"file" => %Plug.Upload{filename: file_name} = _file} = _attrs
       ) do
    file_ext = Path.extname(file_name)
    case file_ext in IncidentReport.Service.LocalFilehandler.supported_images_types() do
      true ->
        changeset

      false ->
        changeset
        |> Map.put(:valid?, false)
        |> add_error(:file, "file extension is not supported", [])
    end
  end

  defp validate_image_file_extension(%{valid?: false} = changeset, _attrs), do: changeset

  defp validate_email(%{valid?: true} = changeset, %{"email" => email} = _attrs) do
    case Regex.match?(~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/, email) do
      true ->
        changeset

      false ->
        changeset
        |> Map.put(:valid?, false)
        |> add_error(:email, "invalid", [])
    end
  end

  defp validate_email(%{valid?: true} = changeset, _attrs) do
    changeset
    |> Map.put(:valid?, false)
    |> add_error(:email, "required", [])
  end

  defp validate_email(%{valid?: false} = changeset, _attrs), do: changeset
end
