class Item < ApplicationRecord
  belongs_to :collection
  has_many :transactions
  has_one :image, as: :imageable

  def user
    collection.user
  end

  def remaining_amount
    return nil if !amount

    return amount - transactions.sum(:amount)
  end
end
