class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.belongs_to :department
      t.integer :login_count
      t.string :type
      t.boolean :is_member
      t.timestamps
    end
  end
end
