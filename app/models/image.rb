class Image < ApplicationRecord
belongs_to :imageable, polymorphic: true
belongs_to :user
after_save :call_image_job
has_attached_file :image, styles: {
        thumb: "100x100>", small: "300x300>", medium: "600x600>" , large: "1200x1200>"
    },
    default_url: "",
    :path => "images/:id/:style/:filename"

validates :tmp_url, presence: true
validate :user_has_to_be_imageable_user
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

  private
  def user_has_to_be_imageable_user
    errors.add(:user, 'has to be equal to imageable user') unless user == imageable.user
  end
end
