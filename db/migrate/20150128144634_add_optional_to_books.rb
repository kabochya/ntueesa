class AddOptionalToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :optional,:bool
  end
end
