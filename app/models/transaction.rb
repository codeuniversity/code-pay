class Transaction < ApplicationRecord
  enum status: [:outstanding, :done]

  belongs_to :item
  belongs_to :user

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validate :enough_items_available, on: :create
  def receiver
    item.collection.user
  end

  def cost
    item.price * amount
  end

  private
  def enough_items_available
    remaining_amount = item.remaining_amount
    errors.add(:amount, 'not enough items left') unless remaining_amount == nil || remaining_amount - amount >= 0
  end
end
