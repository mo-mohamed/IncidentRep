defmodule IncidentReport.Service.LocalFilehandler do
  @supported_images_format [".jpg", ".jpeg", ".png", ".JPG"]

  def save_file_from_upload(file_plug) do
    file_name = Ecto.UUID.generate()
    file_ext = Path.extname(file_plug.filename)
    File.cp(file_plug.path, File.cwd!() <> "/media/#{file_name}.#{file_ext}")
    {:ok, file_name}
  end

  def supported_images_types, do: @supported_images_format
end
