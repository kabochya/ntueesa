class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :user, index: true
      t.boolean :is_paid, default: false
      t.boolean :is_confirmed, default: false
      t.string :payment_code

      t.timestamps
    end
  end
end
