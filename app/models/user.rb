class User < ActiveRecord::Base

  has_many :collections
  has_many :transactions


  # Include default devise modules.
  devise :database_authenticatable,
    :rememberable, :trackable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
