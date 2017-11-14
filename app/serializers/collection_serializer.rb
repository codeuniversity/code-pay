class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user
  has_many :items
  has_many :images
  has_one :main_image

  def main_image
    object.images.order(created_at: :asc).first
  end
end
