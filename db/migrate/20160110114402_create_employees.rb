class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string  "lastname"
      t.string  "firstname"
      t.integer "irdcode", index: true
      t.string "taxcode"
      t.decimal  "accprocent",      precision: 10, scale: 2
      t.references :users, index: true
      t.string "fio", index: true
      t.decimal  "taxprocent",      precision: 10, scale: 2
      t.integer "kiwisaver"
       
      t.timestamps null: false
    end
    
  end
end
