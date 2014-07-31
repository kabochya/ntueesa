class AddDeptCodeToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :dept_code, :string
  end
end
