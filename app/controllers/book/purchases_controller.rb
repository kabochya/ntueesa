class Book::PurchasesController < Book::ApplicationController
	before_action :authenticate_user!
	def create
		u=current_user
		act_pay=u.payments.active
		ord=u.purchases.where(book_id: params[:book_id])
		if ord.exists? # The user already bought the book
			render json: {status: 0}
		elsif act_pay.exists? # The user has a payment not paid yet
			o=act_pay.first.purchases.create(book_id: params[:book_id])
			render json: {status: 1, purchase_id: o.id }
		else # The user has no pending payments
			newpay=u.payments.create
			o=newpay.purchases.create(book_id: params[:book_id])
			render json: {status: 1, purchase_id: o.id }
		end
		#redirect_to book_list_path
	end

	def destroy
		#params[:id] is the book's id to destroy
		act_pay=current_user.payments.active
		if act_pay.exists? # Check if user has active payment
			ord=act_pay.first.purchases.where(book_id: params[:id])
			if ord.exists? #Check if the active payment has the book
				ord.first.delete
				render json: {status: 1}
			else
				render json: {status: 0}
			end
		else
			render json: {status: 0}
		end
	end
end
