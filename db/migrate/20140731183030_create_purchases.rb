class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :book, index: true
      t.belongs_to :payment, index: true

      t.timestamps
    end
  end
end
