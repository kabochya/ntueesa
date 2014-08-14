class Payment < ActiveRecord::Base
  belongs_to :user
  has_many :purchases

  scope :active, -> { where(status: 0) }

  ACTIVE=0
  CHECKEDOUT=1
  PAID=2
  CONFIRMED=3

  def status_class
  	class_arr=['active-payment-label','checked-out-payment-label','paid-payment-label','confirmed-payment-label']
  	return class_arr[status]
  end
  def status_label
  	label_arr=['未結帳','待付款','待確認','完成訂單']
  	return label_arr[status]
  end
end
