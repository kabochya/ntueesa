class AddStatusToDepartmentBooks < ActiveRecord::Migration
  def change
  	add_column :department_books, :status, :integer,  default: 1
  end
end
