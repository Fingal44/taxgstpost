class CreateDatesettings < ActiveRecord::Migration
 def change
    create_table :datesettings do |t|
      
      t.references :users, null: false, index: true
      t.date "startdate"
      t.date "enddate"
     
      t.timestamps null: false
    end
  end
end
