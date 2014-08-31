class Book::SessionsController < Devise::SessionsController
  before_action :system_closed
	after_action :log_failed_login, :only => :new
	layout "book/login"
  def department_closed
    
  end
	def after_sign_in_path_for(resource_or_scope)
    if (Setting.phase==0)||(current_book_department.settings.phase==0)
      book_closed_path
    else
      book_department_path
    end
	end
	def after_sign_out_path_for(resource_or_scope)
  	 new_book_department_session_path
	end

  def system_closed
    if Setting.phase==0
      redirect_to book_closed_path
    end
  end

  def create
    super
    BookLog.create!(action:'login',role:'Department',role_id: current_book_department.id,location:request.remote_ip)
  end

  private
  def log_failed_login
    BookLog.create!(action:'login_fail',role:'Department',location:request.remote_ip, message:'Department login failed where dept_account: '+params[:book_department][:dept_account].to_s) if failed_login?
  end 

  def failed_login?
    (options = env["warden.options"]) && options[:action] == "unauthenticated"
  end 
end