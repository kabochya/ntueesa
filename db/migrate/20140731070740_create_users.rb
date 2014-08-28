class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.belongs_to :department
      t.integer :login_count, default: 0
      t.string :type
      t.boolean :is_member, default: false
      t.timestamps
    end
  end
end
