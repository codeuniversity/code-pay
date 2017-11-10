class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items, id: :uuid do |t|
      t.string :name
      t.decimal :price, precision: 15, scale: 2
      t.integer :amount
      t.references :collection, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
