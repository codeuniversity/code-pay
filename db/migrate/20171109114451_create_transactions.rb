class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :amount, default: 1
      t.references :item, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
