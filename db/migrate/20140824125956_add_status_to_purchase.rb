class AddStatusToPurchase < ActiveRecord::Migration
  def change
  	add_column :purchases, :status, :boolean, default: false
  end
end
