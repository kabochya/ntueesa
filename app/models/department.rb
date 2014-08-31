class Department < ActiveRecord::Base
  include RailsSettings::Extend
  after_create :default_phase
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :timeoutable, :rememberable, :trackable, :validatable, authentication_keys:[:dept_account]
  has_many :users
  has_many :payments, through: :users
  has_many :department_books
  has_many :books, through: :department_books
  has_many :purchases, through: :books

  def default_phase
    self.settings.phase = 0
  end
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def total_recievable
    sum=0
    books.each do |b|
      b_com=users.has_book_in_payment(b.id,3)
      mem_amount=b_com.where(is_member:true).count
      non_amount=b_com.where(is_member:false).count
      mem_price=b.member_price(id)
      non_price=b.nonmember_price(id)
      sum+=mem_price*mem_amount+non_amount*non_price
    end
    return sum
  end

  def total_payable
    sum=0
    books.each do |b|
      count=users.has_book_in_payment(b.id,3).count
      cost=b.price
      sum+=count*cost
    end
    return sum
  end
end
