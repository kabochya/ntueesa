class Book::PaymentsController < Book::ApplicationController
  skip_before_action :auth_user!, only: [:confirm,:show]
  before_action :authenticate_book_department!, only: [:confirm,:show]
  skip_before_action :department_closed, only:[:confirm,:show]
  before_action only: :destroy do 
    block_phase 2
  end

  before_action except: [:confirm,:show] do 
    block_phase 3
  end

  def index
    @payments=current_user.payments.where('`status` < 4').order('status ASC')
  end
  def show #details for admin
    if (pay = current_book_department.payments.where(id:params[:id]).first)
      render partial: '/book/departments/payment_details', locals:{payment:pay}
    else
      render inline:"<%= '無法存取' %>"
    end
  end

  def destroy
    if pay=current_user.payments.where(id: params[:id],status:1).first
      pay.purchases.each do |pur|
        pur.destroy
        BookLog.success_record('unpurchase',current_user,pur.book)
      end
      pay.destroy
      BookLog.success_record(action_name,current_user,pay)
      render json: {status:1}
    else
      BookLog.fail_record(action_name,current_user,Payment,"Failed to destroy Payment "+params[:id].to_s)
      render json: {status:0}
    end
  end
  
  def checkout
    if pay=current_user.payments.where(id: params[:id],status:0).first
      pay.status=1
      pay.save
      BookLog.success_record(action_name,current_user,pay)
      html = render_to_string(:template => 'book/payments/_accordion.html.erb',
             :formats=>["html"],:layout=>false,
             :locals => {p: pay})

      render json: {status:1, html:html}
      return
    end
    BookLog.fail_record(action_name,current_user,Payment,"Failed to checkout Payment "+params[:id].to_s)
    render json: {status:0}
  end

  def pay
    if params[:confirm_code].size!=0
      if pay=current_user.payments.where(id: params[:id], status:1, payment_code:nil).first
        pay.status=2
        pay.payment_code=params[:confirm_code]
        BookLog.success_record(action_name,current_user,pay)
        pay.save
        html = render_to_string(:template => 'book/payments/_accordion.html.erb',
             :formats=>["html"],:layout=>false,
             :locals => {p: pay})
        render json: {status:1, html:html}
        return
      end
    end
    BookLog.fail_record(action_name,current_user,Payment,"Failed to pay Payment "+params[:id].to_s)
    render json: {status: 0}
  end

  def modify_code
    if params[:confirm_code].size!=0
      if pay=current_user.payments.where(id: params[:id], status:2).first
        pay.payment_code=params[:confirm_code]
        BookLog.success_record(action_name,current_user,pay)
        pay.save
        render json: {status:1}
        return
      end
    end
    BookLog.fail_record(action_name,current_user,Payment,"Failed to modify Payment "+params[:id].to_s+" code to "+params[:confirm_code].to_s)
    render json: {status: 0}
  end

  def confirm # Finish payment by admin
    if pay=current_book_department.payments.where(id:params[:id],status: 2).where('`payment_code` IS NOT NULL').first
      pay.status=3
      BookLog.success_record(action_name,current_book_department,pay)
      pay.save
      render json: {status: 1}
    else
      BookLog.fail_record(action_name,current_book_department,Payment,"Failed to confirm Payment "+params[:id].to_s)
      render json: {status: 0}
    end
  end
end
