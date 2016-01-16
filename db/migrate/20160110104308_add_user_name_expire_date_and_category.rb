class AddUserNameExpireDateAndCategory < ActiveRecord::Migration
    def change
      add_column :users, :name, :string
      add_column :users, :category, :integer
      add_column :users, :expire_date, :date
    end
end
