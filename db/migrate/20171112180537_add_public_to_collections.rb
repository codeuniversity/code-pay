class AddPublicToCollections < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :public, :boolean, default: :false
  end
end
