class AddRemarkToUsers < ActiveRecord::Migration
  def change
  	add_column :users,:remark,:text
  end
end
