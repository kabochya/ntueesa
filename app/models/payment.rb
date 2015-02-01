class Payment < ActiveRecord::Base
  belongs_to :user
  has_many :purchases
  has_many :books , through: :purchases
  scope :active, -> { where(status: 0) }

  ACTIVE=0
  CHECKEDOUT=1
  PAID=2
  CONFIRMED=3

  def status_class
  	class_arr=['active-payment-label','checked-out-payment-label','paid-payment-label','confirmed-payment-label','unreceived-payment-label','recieved-payment-label']
  	return class_arr[status]
  end
  def status_label
  	label_arr=['未結帳','待付款','待確認','完成訂單','未領完','完成領取']
  	return label_arr[status]
  end

  def cost
    dept_id=user.department.id
    sum=0
    
    if user.is_member  
      books.each do |b|
        sum+=b.member_price(dept_id)
      end
    else
      books.each do |b|
        sum+=b.nonmember_price(dept_id)
      end
    end

    return sum
  end
end
