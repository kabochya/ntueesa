class Book::ApplicationController < ApplicationController

	protected

	def authenticate_user!
		unless session[:user_id]
			redirect_to book_logout_path
			return false
		end
		return true
	end

end
