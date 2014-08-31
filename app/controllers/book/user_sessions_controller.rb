class Book::UserSessionsController < Book::ApplicationController
  #before_action :system_closed
	before_action :user_logined, only: [:new,:create]
  skip_before_action :auth_user!, only: [:new,:create]
  skip_before_action :department_closed, only: [:new,:create]
  #before_action :auth_user!, only: :destroy
  layout "book/login"
  def system_closed
    super
  end
  def user_logined
    if session[:user_id]&&(session[:expires_at]>Time.current)
      redirect_to book_shop_path
      return false
    end
    return true
  end

	def new
	end

	def create
    if (user = User.where(account: params[:account]).first)
      # User auth method is inherited
      if user.authenticate(params[:password])==User::LOGIN_SUCCESS
      	session[:user_id] = user.id
        session[:expires_at] = Time.current+30.minutes
      	user.update(login_count: user.login_count+1)
      	user.save
        BookLog.create!(action:'login',role:'User',role_id: user.id,location:request.remote_ip)
      	redirect_to after_login_redirect_path, notice: "登入成功"
      else
      	#flash.alert = "Invalid account or password."
        BookLog.create!(action:'login_fail',role:'User',location:request.remote_ip,message:'User login failed where account: '+params[:account].to_s)
      	redirect_to book_login_path, alert:"帳號或密碼錯誤"
      end
    else
      #flash.alert = "Invalid login."
      BookLog.create!(action:'login_fail',role:'User',location:request.remote_ip,message:'User login with invalid account: '+params[:account].to_s)
      redirect_to book_login_path, alert:"帳號或密碼錯誤"
    end
  end

  def destroy
  	session[:user_id] = nil
    session[:expires_at] = nil
  	redirect_to after_login_redirect_path, :notice => "已登出"
  end
  
protected

  def after_login_redirect_path
    if phase 0
      book_closed_path
    elsif phase 1
      book_shop_path
    elsif phase 2
      book_payments_path
    else
      return false
    end
  end
end

