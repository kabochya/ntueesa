class Book::AdminsController < Book::ApplicationController
	layout 'application'
	skip_before_action :auth_user!
	before_action :auth_admin!, except: [:new, :create]
	def new #new login

	end

	def create #create login session
		credhash=Setting.admin_credentials
		if credhash[params[:account]]==Digest::SHA256.new.digest(params[:password])
			session[:admin]=true
			redirect_to book_admin_path, alert:'Login success'
		else
			redirect_to login_book_admin_path, alert:'Invalid Account or password'
		end
	end

	def show
		@settings=Setting.unscoped
		@departments=Department.all
	end
	def edit
		@settings=Setting.unscoped

	end
	def update
		if params[:admin_email]!=''
			Setting.admin_email=params[:admin_email]
		end
		if params[:system_phase]=='on'
			Setting.phase=1
		else
			Setting.phase=0
		end
		render 'edit'
	end

	def destroy
			session[:admin]=nil
			redirect_to login_book_admin_path, alert:'Logout success'
	end

	def create_dept
			begin
				Department.create!(dept_account:params[:dept_account],password:params[:password],dept_name:params[:dept_name],has_member: params[:has_member] ? true : false,payment_info: params[:payment_info].length>0 ? params[:payment_info] : nil)
				redirect_to edit_book_admin_path, alert:'Successfully created dept'
			rescue 
			redirect_to edit_book_admin_path, alert:'Failed to create dept'
			end
	end

	def import_users
			Department.find(params[:department_id]).import_users(params[:file])
			redirect_to edit_book_admin_path, alert:'Successfully imported users'
	end
	def import_books
			Department.find(params[:department_id]).import_books(params[:file])
			redirect_to edit_book_admin_path, alert:'Successfully imported books'
	end

	def dept_edit_phase
		d=Department.find(params[:department_id])
		render partial: 'dept_edit_phase', locals:{d:d}
	end

	def dept_update_phase
		d=Department.find(params[:id])
		case params[:dept_phase]
		when 'off'
		d.settings.phase=0
		when 'buy'	
		d.settings.phase=1
		when 'confirm'
		d.settings.phase=2
		when 'dist'
		d.settings.phase=3
	end
	redirect_to edit_book_admin_path, alert:'Successfully changed department phase'
	end
	private
	def auth_admin!
		if !session[:admin]
			redirect_to login_book_admin_path, alert:'Login first'
		end
	end
end
