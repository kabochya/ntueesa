class Book::AdminsController < Book::ApplicationController
	layout :false
	skip_before_action :auth_user!
	def show
		@settings=Setting.unscoped
	end
	def edit
		@settings=Setting.unscoped
	end
end
