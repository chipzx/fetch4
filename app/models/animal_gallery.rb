class AnimalGallery < ActiveRecord::Base

  DEFAULT_URL="http://s3.amazonaws.com/fetch4-test/animal_galleries/photos/missing.jpg"

  has_attached_file :photo, 
    storage: :s3,
    s3_credentials: Proc.new { |a| a.instance.s3_credentials },
    s3_storage_class: :reduced_redundancy,
    styles: { default: "640x480", small: "320x240", thumb: "140x140"}, 
    default_url: DEFAULT_URL

#  validates_attachment_content_type :photo, content_type: 
#    { content_type: ["image/jpeg", 
#                     "image/jpg", 
#                     "image/gif", 
#                     "image/png", 
#                     "image/tiff"],
#      message: "Invalid content type" 
#    }

  validates_attachment_file_name :photo, 
    matches: [/png\Z/, /jpe?g\Z/, /gif\Z/, /tiff\Z/]

  validates_with AttachmentSizeValidator, attributes: :photo, 
    less_than: 10.megabytes

  def s3_credentials
    {
      bucket: Rails.application.secrets.s3_bucket_name,
      access_key_id: Rails.application.secrets.s3_access_key_id,
      secret_access_key: Rails.application.secrets.s3_secret_access_key
    }
  end

  def as_json(options={})
    { id: id, 
      animal_id: animal_id, 
      primary_image: primary_image, 
      photo_file_name: photo_file_name, 
      photo_file_size: photo_file_size, 
      photo_content_type: photo_content_type, 
      photo_updated_at: photo_updated_at, 
      url_original: photo.url, 
      url_default: photo.url(:default), 
      url_small: photo.url(:small), 
      url_thumb: photo.url(:thumb) 
    }.as_json(options)
  end

end
