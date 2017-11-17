class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :status, :cost, :created_at, :updated_at
  has_one :item
  has_one :user
end
