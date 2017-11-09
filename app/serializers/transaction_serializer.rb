class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :status
  has_one :item
  has_one :user
end
