class Image < ApplicationRecord
belongs_to :imageable, polymorphic: true
after_save :call_image_job
has_attached_file :image, styles: {
        thumb: "100x100>", small: "200x200>", medium: "400x400>" , large: "800x800>"
    },
    default_url: "",
    :path => "images/:id/:style/:filename"

validates :tmp_url, presence: true
# validates_attachment_file_name :image, :matches =>  /\Aimage\/.*\Z/
# validates_attachment_content_type :image, content_type: /image/
# validates_attachment :image, content_type: { content_type: "image/png" }
# validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }
do_not_validate_attachment_file_type :image

def call_image_job
    if tmp_url_changed?
      processed=false
      ImageWorker.perform_async(self.id)
    end
  end
end
