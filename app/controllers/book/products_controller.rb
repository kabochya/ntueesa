class Book::ProductsController < Book::ApplicationController
  #before_action :auth_user!
  before_action do 
    block_phase 2
  end

  before_action do 
    block_phase 3
  end
  def index
    @items=Book.all
    @d=current_user.department
  end
  def purchase
    u=current_user
    if !u.department.books.where(id:params[:book_id]).exists?
      BookLog.fail_record(action_name,current_user,Book,"Failed to purchase book "+params[:book_id].to_i)
      render json: {status: 0}
      return
    end
    case u.purchase_validate params[:book_id]
      when 0
        act_pay=u.payments.active
        if act_pay.exists?
          p=act_pay.first.purchases.create(book_id: params[:book_id])
        else
          newpay=u.payments.create
          BookLog.success_record('create',current_user,newpay)
          p=newpay.purchases.create(book_id: params[:book_id])
        end
        BookLog.success_record(action_name,current_user,p.book)
        render json: {status: 1, purchase_id: p.id }
      when 1..2
        BookLog.fail_record(action_name,current_user,Book,"Failed to purchase book "+params[:book_id].to_i)
        render json: {status: 0}
    end
  end

  def unpurchase
    #params[:id] is the book's id to destroy
    pur=current_user.purchases.where(book_id: params[:id]).first
      if pur&&(pur.payment.status==0)
        BookLog.success_record(action_name,current_user,pur.book)
        pur.destroy
        if pur.payment.purchases.empty?
          BookLog.success_record('destroy',current_user,pur.payment)
          pur.payment.destroy
        end
        render json: {status: 1}
      else
        BookLog.fail_record(action_name,current_user,Book,"Failed to destroy purchase of book "+params[:book_id].to_i)
        render json: {status: 0}
      end
  end
end
