class AnimalGallery < ActiveRecord::Base

  has_one :animal

  has_attached_file :photo, 
    url: "/system/:attachment/:id/:style/:filename",
    path: ":rails_root/public:url",
    styles: { default: "640x480", small: "320x240", thumb: "140x140"}, 
    default_url: "images/missing.jpg" 

#  do_not_validate_attachment_file_type :photo
#  validates_attachment_content_type :photo, content_type: 
#    { content_type: ["image/jpeg", 
#                     "image/jpg", 
#                     "image/gif", 
#                     "image/png", 
#                     "image/tiff"] 
#    }
#
  validates_attachment_file_name :photo, 
    matches: [/png\Z/, /jpe?g\Z/, /gif\Z/, /tiff\Z/]

  validates_with AttachmentSizeValidator, attributes: :photo, 
    less_than: 10.megabytes

end
