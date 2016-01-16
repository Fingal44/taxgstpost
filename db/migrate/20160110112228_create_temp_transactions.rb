class CreateTempTransactions < ActiveRecord::Migration
  def change
    create_table :temp_transactions do |t|
      t.date :date, index: true
      t.decimal :amounttotal, :precision => 10, :scale => 2
      t.integer :gsttype
      t.decimal :gstamount, :precision => 10, :scale => 2
      t.decimal :netamount, :precision => 10, :scale => 2
      t.integer :co
      t.integer :code, index: true
      t.references :users, null: false, index: true
      t.references :chart_clones, index: true
      t.string :what
      t.string :who
      t.integer  :gst_include

      t.timestamps
    end
    
  end
end
