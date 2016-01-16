class Transaction < ActiveRecord::Base
 # belongs_to :user 
 # include ActiveModel::ForbiddenAttributesProtection
 # has_many :chart_clones
 # has_many :charts
 attr_accessor :extra_tax, :extra_acc, :extra_sl, :extra_ks, :extra_all
 validates_presence_of :amounttotal
 # validates :amounttotal, presence: true
 validates :amounttotal,:numericality => {:greater_than_or_equal_to => 0.01}

 #validate :amounttotal_value_order, :on => :create
 # validates :amounttotal, numericality: => {:greater_than 0}

 # private 
 
 # def initialize
  #  @errors = ActiveModel::Errors.new(self)
  # end
 
end
