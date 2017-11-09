class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 15, scale: 2
      t.integer :amount
      t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end
