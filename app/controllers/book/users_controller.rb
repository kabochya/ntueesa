class Book::UsersController < Book::ApplicationController
	skip_before_action :auth_user!
	before_action :authenticate_book_department!
	skip_before_action :department_closed
  # Methods below are for dept admins
  def show
  	if (user = current_book_department.users.where(id:params[:id]).first)
      render partial: '/book/departments/user_details', locals:{user:user}
    else
      render inline:"<%= '無法存取' %>"
    end
  end
  def modify_membership
  	if current_book_department.has_member
  		u=current_book_department.users.where(id:params[:id]).first
  		u.is_member=u.is_member ? false : true
  		u.save
      BookLog.success_record(action_name,current_book_department,u)
  		render json:{status:1}
  	else
      BookLog.fail_record(action_name,current_book_department,User,"Failed to modify membership of user "+params[:id].to_i)
  		render json:{status:0}
  	end
  end
  
  def book_list
    if (user = current_book_department.users.where(id:params[:id]).first)
      render partial: '/book/departments/user_book_list', locals:{user:user}
    else
      render inline:"<%= '無法存取' %>"
    end
  end

end
