class Book::DepartmentsController < ApplicationController
	layout "book/department"
	before_action :authenticate_book_department!
  def show
  	@d = current_book_department  	
  	@books = @d.books
  end
	def payments
		@meth_i=0
		meth_arr=[1..3,1,2,3]
		if (0..3).include?(params[:meth].to_i)
			@meth_i=params[:meth].to_i
		end
		meth=meth_arr[@meth_i]
		if params[:search].nil?||params[:search]==''
			@payments = current_book_department.payments.where(status:meth).order("id ASC").page(params[:page])
		else
			@payments = current_book_department.payments.where(status:meth, payment_code:params[:search]).order("id ASC").page(params[:page])
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	def users
		if params[:search].nil?||params[:search]==''
			@users = current_book_department.users.order("id ASC").page(params[:page])
		else
			@users = current_book_department.users.where(account:params[:search]).order("id ASC").page(params[:page])
		end
		respond_to do |format|
			format.html
			format.js
		end
	end

	def books

	end
end
