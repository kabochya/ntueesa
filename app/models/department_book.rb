class DepartmentBook < ActiveRecord::Base
  belongs_to :department
  belongs_to :book
end
