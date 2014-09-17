class Book::PurchasesController < Book::ApplicationController
  skip_before_action :auth_user!
  skip_before_action :department_closed
  before_action :authenticate_book_department!

  def status
  	if (user = current_book_department.users.where(id:params[:id]).first)
	  	if(pur = user.purchases.where(id:params[:purchase_id]).first)
	  		mod_stat pur
	  		cur_pay=pur.payment
	  		old_status=cur_pay.status
	  		if cur_pay.purchases.count==cur_pay.purchases.where(status:true).count
	  			cur_pay.status=5
	  		else
	  			cur_pay.status=4
	  		end
	  		cur_pay.save
	  		render json:{status:1,payment_status:(cur_pay.status==old_status) ? 0 : cur_pay.status}
	  	else
	  		BookLog.fail_record(action_name,current_book_department,Purchase,"Failed to modify status of purchase "+ id.to_i)
	  		render json:{status:0}
	  	end
	  else
	  	BookLog.fail_record(action_name,current_book_department,Purchase,"No permission to modify status of purchase "+params[:purchase_id].to_i)
	  	render json:{status:0}
	  end
  end

  def status_all
  	if (user = current_book_department.users.where(id:params[:id]).first)
	  	user.purchases.where(status:false).each do |pur|
	  		mod_stat pur
	  	end
	  	render json:{status:1}
	  else
	  	BookLog.fail_record(action_name,current_book_department,Purchase,"No permission to modify all purchases status of User "+params[:id].to_i)
	  	render json:{status:0}
	  end
	  	
  end
protected

  def mod_stat pur
			pur.status = pur.status ? false : true
			pur.save
  		BookLog.success_record(action_name+'_'+pur.status.to_s,current_book_department,pur)
  end
end
