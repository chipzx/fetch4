class AnimalGallery < ActiveRecord::Base

  has_one :animal

  has_attached_file :photo, 
    storage: :s3,
    s3_credentials: Proc.new { |a| a.instance.s3_credentials },
    s3_storage_class: :reduced_redundancy,
    styles: { default: "640x480", small: "320x240", thumb: "140x140"}, 
    default_url: "images/missing.jpg" 

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

end
