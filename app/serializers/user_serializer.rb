class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :image, :name, :nickname
end
