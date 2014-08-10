class Department < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, authentication_keys:[:dept_account]
  has_many :users
  has_many :payments, through: :users
  has_many :department_books
  
  def email_required?
    false
  end

  def email_changed?
    false
  end

end
