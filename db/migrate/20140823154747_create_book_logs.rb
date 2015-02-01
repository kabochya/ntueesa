class CreateBookLogs < ActiveRecord::Migration
  def change
    create_table :book_logs do |t|
    	t.string :role
    	t.integer :role_id
    	t.string :action
    	t.string :object
    	t.string :object_id
    	t.string :location
    	t.string :message
      t.timestamps
    end
  end
end
