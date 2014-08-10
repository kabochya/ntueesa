class Book::ProductsController < Book::ApplicationController
	before_action :authenticate_user!
	def show
		@items=Book.all
	end
end
