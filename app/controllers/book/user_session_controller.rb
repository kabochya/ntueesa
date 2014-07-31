class Book::UserSessionController < Book::ApplicationController
	def new
	end

	def create
    user = User.where(account: params[:account]).first
    if user
      auth = user.authenticate(params[:account],params[:password])
      if auth 
      	session[:user_id] = user.id
      	user.login_count+=1
      	user.save
      	redirect_to root_url, :notice => "Logged in!"
      else
      	flash.now.alert = "Invalid account or password."
      	render "new"
      end
    else
      flash.now.alert = "Invalid login."
      render "new"
    end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Logged out!"
  end
end
