class Item < ApplicationRecord
  belongs_to :collection
  has_many :transactions
  has_one :image, as: :imageable, dependent: :destroy

  validates :price, presence: true,numericality: { greater_than: 0 }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true


  def user
    collection.user
  end

  def remaining_amount
    return nil if !amount

    return amount - transactions.sum(:amount)
  end
end
