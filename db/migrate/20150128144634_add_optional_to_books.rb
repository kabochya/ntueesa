class AddOptionalToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :optional,:boolean, default: false
  end
end
