class AddDeptCodeToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :dept_name, :string
    add_column :departments, :has_member, :boolean, default: false
  end
end
