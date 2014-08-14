class AddStatusToPayments < ActiveRecord::Migration
  def change
  	add_column :payments, :status, :integer, default: 0
  	remove_column :payments, :is_paid, :boolean, default: false
  	remove_column :payments, :is_confirmed, :boolean, default: false
  end
end
