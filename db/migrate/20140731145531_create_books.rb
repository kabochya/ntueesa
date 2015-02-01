class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :image_link
      t.integer :price

      t.timestamps
    end
  end
end
