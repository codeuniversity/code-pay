class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :amount
  belongs_to :collection
  has_one :image
end
