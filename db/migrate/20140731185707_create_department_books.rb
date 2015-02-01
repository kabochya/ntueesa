class CreateDepartmentBooks < ActiveRecord::Migration
  def change
    create_table :department_books do |t|
      t.string :course
      t.integer :member_adj, default: 0
      t.integer :nonmember_adj, default: 0
      t.belongs_to :department, index: true
      t.belongs_to :book, index: true

      t.timestamps
    end
  end
end
