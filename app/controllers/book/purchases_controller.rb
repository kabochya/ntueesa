class Book::PurchasesController < Book::ApplicationController
  before_action :authenticate_user!
  def create
    u=current_user
    case u.purchase_validate params[:book_id]
      when 0
        act_pay=u.payments.active
        if act_pay.exists?
          p=act_pay.first.purchases.create(book_id: params[:book_id])
        else
          newpay=u.payments.create
          p=newpay.purchases.create(book_id: params[:book_id])
        end
        render json: {status: 1, purchase_id: p.id }
      when 1..2
        render json: {status: 0}
    end
  end

  def destroy
    #params[:id] is the book's id to destroy
    pur=current_user.purchases.where(book_id: params[:id]).first
      if pur&&(pur.payment.status==0)
        pur.delete
        if pur.payment.purchases.empty?
          pur.payment.delete
        end
        render json: {status: 1}
      else
        render json: {status: 0}
      end
  end
end
