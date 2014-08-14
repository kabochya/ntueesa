class Book::DepartmentsController < ApplicationController
	before_action :authenticate_book_department!
  def show
  	d=current_book_department
  	@d_users=d.users
  	@d_payments=d.payments
  end
end
