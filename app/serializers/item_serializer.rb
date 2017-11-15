class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :amount, :amount_left
  belongs_to :collection
  has_one :image
  def amount_left
  object.remaining_amount
  end
end
