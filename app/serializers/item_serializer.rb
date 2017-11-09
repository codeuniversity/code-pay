class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :amount
  has_one :collection
end
