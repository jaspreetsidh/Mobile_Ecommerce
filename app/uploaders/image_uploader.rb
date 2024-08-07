
class ImageUploader < CarrierWave::Uploader::Base
  # Include CarrierWave::MiniMagick for image resizing
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader
  storage :file
  # storage :fog # Use AWS S3 or other cloud storage if needed

  # Process files as they are uploaded:
  process resize_to_fill: [300, 300]

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  # Add a default image if there is none
  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end
end

