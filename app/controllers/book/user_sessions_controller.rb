class Book::UserSessionsController < Book::ApplicationController
	before_action :user_logined, only: [:new,:create]
  before_action :authenticate_user!, only: :destroy
	def new
	end

	def create
    user = User.where(account: params[:account]).first
    if user
      # User auth method is inherited
      auth = user.authenticate params[:password]
      if auth==User::LOGIN_SUCCESS
      	session[:user_id] = user.id
        session[:expires_at] = Time.current+30.minutes
      	user.update(login_count: user.login_count+1)
      	user.save
      	redirect_to book_list_path, notice: "Logged in!"
      else
      	#flash.alert = "Invalid account or password."
      	redirect_to book_login_path, alert:"Invalid account or password."
      end
    else
      #flash.alert = "Invalid login."
      redirect_to book_login_path, alert:"Invalid login."
    end
  end

  def destroy
  	session[:user_id] = nil
    session[:expires_at] = nil
  	redirect_to book_list_path, :notice => "Logged out!"
  end
end
