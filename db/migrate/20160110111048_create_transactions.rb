class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date, null: false, index: true
      t.integer :code, null: false, index: true
      t.decimal :amounttotal, :precision => 10, :scale => 2
      t.integer :gsttype
      t.decimal :gstamount, :precision => 10, :scale => 2
      t.decimal :netamount, :precision => 10, :scale => 2
      t.references :users, null: false, index: true
      t.references :chart_clones, null: false, index: true
      t.integer :co
      t.integer  :gst_include
     
      t.timestamps
    end
  end  
end
