class Book::ApplicationController < ApplicationController
	layout "book/user"
	#before_action :destroy_department_session
	before_action :system_closed, except: :closed
	before_action :department_closed,except: :closed
	before_action :auth_user!,except:[:closed,:prohibited]

	def system_closed
    if (Setting.phase==0)
      redirect_to book_closed_path
    end
  end
  def department_closed
    if (current_user.department.settings.phase==0)||(current_user.department.settings.phase==3)
      redirect_to book_closed_path
    end
  end
	def block_phase ph
		if current_user.department.settings.phase == ph
			respond_to do |format|
				format.html {redirect_to  book_prohibited_path }
				format.json {render json: {status:-1}}
			end
			return false
		end
		return true
	end

	def prohibited
		
	end

	def closed
		render 'closed', layout: 'application'
	end

	def destroy_department_session
		if book_department_signed_in?
			sign_out(current_book_department)
		end
		return true
	end
	
	def auth_user!
		unless session[:user_id]&&session[:expires_at]
			respond_to do |format|
		      format.html { redirect_to book_login_path }
		      format.json { render json:{location:book_login_path} }
		    end
			return false
		end

		if session[:expires_at]<Time.current
			session[:user_id] = nil
			session[:expires_at] = nil
		    respond_to do |format|
		      format.html { redirect_to book_login_path }
		      format.json { render json:{location:book_login_path} }
		    end
			#redirect_to book_login_path
			return false
		else
			session[:expires_at]=Time.current+30.minutes
			return true
		end
	end
	
	def current_user
		@current_user ||=User.find(session[:user_id]) if session[:user_id]
	end

	def phase ph
		case ph.class.to_s
		when 'Range'
			ph.include?(current_user.department.settings.phase)
		when 'Fixnum'
			ph==current_user.department.settings.phase
		else
			return false
		end
	end

	def user_signed_in?
		session[:user_id].present?
	end

	helper_method :current_user
	helper_method :phase
end
