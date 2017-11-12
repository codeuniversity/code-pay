class User < ActiveRecord::Base

  has_many :collections
  has_many :transactions


  # Include default devise modules.
  devise :database_authenticatable,
    :rememberable, :trackable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  def outstanding_money
    transactions.joins(:item).sum('transactions.amount * items.price').to_f
  end

end
