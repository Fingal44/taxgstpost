class ChartClone < ActiveRecord::Base
  has_many :charts
  # belongs_to :transaction
end
