class Book::PaymentsController < Book::ApplicationController
  before_action :authenticate_user!
  def index
    @payments=current_user.payments.where('`status` < 4').order('status ASC')
  end

  def destroy
    pay=current_user.payments.where(id: params[:id],status:1).first
    if pay
      pay.delete
      pay.purchases.each do |pur|
        pur.delete
      end
      render json: {status:1}
    else
      render json: {status:0}
    end
  end
  def checkout
    pay=current_user.payments.where(id: params[:id],status:0).first
    if pay
      pay.status=1
      pay.save

      html = render_to_string(:template => 'book/payments/_accordion.html.erb',
             :formats=>["html"],:layout=>false,
             :locals => {p: pay})

      render json: {status:1, html:html}
      return
    end
    render json: {status:0}
  end

  def pay
    if params[:confirm_code]
      pay=current_user.payments.where(id: params[:id], status:1, payment_code:nil).first
      if pay
        pay.status=2
        pay.payment_code=params[:confirm_code]
        pay.save
        html = render_to_string(:template => 'book/payments/_accordion.html.erb',
             :formats=>["html"],:layout=>false,
             :locals => {p: pay})
        render json: {status:1, html:html}
        return
      end
    end
    render json: {status: 0}
  end

  def confirm
  end
end
