class Employee < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :irdcode, :accprocent
end
