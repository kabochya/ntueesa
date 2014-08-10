class CreateDepartmentBooks < ActiveRecord::Migration
  def change
    create_table :department_books do |t|
      t.string :course
      t.integer :adjustment
      t.belongs_to :department, index: true
      t.belongs_to :book, index: true

      t.timestamps
    end
  end
end
