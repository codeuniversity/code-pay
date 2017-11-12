class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user
  has_many :items
  has_many :images
end
