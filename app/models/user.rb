class User < ActiveRecord::Base
 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv.add_row column_names
    all.each do |foo|
      values = foo.attributes.values
      csv.add_row values
    end
  end
end
end
