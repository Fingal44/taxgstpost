class Chart < ActiveRecord::Base
#	include ActiveModel::ForbiddenAttributesProtection
  belongs_to :chart_clone
  # belongs_to :transaction
end
