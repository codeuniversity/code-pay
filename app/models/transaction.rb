class Transaction < ApplicationRecord
  belongs_to :item
  belongs_to :user

  def receiver
    item.collection.user
  end
end
