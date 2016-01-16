class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.integer :glcode, index: true
      t.integer :gst
      t.integer :code, null: false, index: true
      t.string :content
      t.integer :header
      t.references :users, index: true
      t.decimal :amount_1, :precision => 10, :scale => 2
      t.decimal :amount_2, :precision => 10, :scale => 2
   
      t.timestamps null: false
    end
   
  end
end
