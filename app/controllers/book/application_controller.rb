class Book::ApplicationController < ApplicationController

	protected

	def authenticate_user!
		unless session[:user_id]&&session[:expires_at]
			redirect_to book_login_path
			return false
		end

		if session[:expires_at]<Time.current
			session[:user_id] = nil
			session[:expires_at] = nil
			redirect_to book_login_path
			return false
		else
			session[:expires_at]=Time.current+30.minutes
			return true
		end
	end
	def user_logined
		if session[:user_id]&&session[:expires_at]
			redirect_to book_list_path
			return false
		end
		return true
	end

	def current_user
		@current_user ||=User.find(session[:user_id]) if session[:user_id]
	end

	def user_signed_in?
		session[:user_id].present?
	end

	helper_method :current_user
end
