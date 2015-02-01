class Purchase < ActiveRecord::Base
  belongs_to :book
  belongs_to :payment
end
