class Payment < ActiveRecord::Base
  belongs_to :user
  has_many :purchases

  scope :active, -> { where(is_paid: false) }
end
