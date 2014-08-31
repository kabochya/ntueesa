class AddPaymentInfoToDepartment < ActiveRecord::Migration
  def change
  	add_column :departments, :payment_info, :text
  end
end
