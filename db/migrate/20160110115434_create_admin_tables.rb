class CreateAdminTables < ActiveRecord::Migration
  def change
    create_table :admin_tables do |t|
      t.string  "name"
      t.date "lastmodified"
      
      t.timestamps null: false
    end
  end
end
