class Transaction < ApplicationRecord
  enum status: [:outstanding, :done]

  belongs_to :item
  belongs_to :user

  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  def receiver
    item.collection.user
  end

  def cost
    item.price * amount
  end
end
