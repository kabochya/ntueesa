class Book < ActiveRecord::Base
	has_many :department_books
	has_many :purchases
	has_many :payments ,through: :purchases
	has_many :users, through: :payments
	def nonmember_price dept_id
		price+department_books.find_by(department_id:dept_id).nonmember_adj
	end

	def member_price dept_id
		price+department_books.find_by(department_id:dept_id).member_adj
	end

end
