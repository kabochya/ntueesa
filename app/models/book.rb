class Book < ActiveRecord::Base
	has_many :department_books
	has_many :purchases
end
