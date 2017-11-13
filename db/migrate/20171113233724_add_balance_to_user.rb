class AddBalanceToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :balance, :decimal, precision: 15, scale: 2, default: 0
  end
end
