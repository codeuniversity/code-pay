class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
      t.string :tmp_url
      t.uuid :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
