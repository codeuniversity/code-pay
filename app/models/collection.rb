class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
end
