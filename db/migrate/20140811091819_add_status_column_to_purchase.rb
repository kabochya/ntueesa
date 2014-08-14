class AddStatusColumnToPurchase < ActiveRecord::Migration
  def change
  	add_column :purchases, :status, :integer, default: 0
  end
end
