class CreateTransferings < ActiveRecord::Migration
  def change
    create_table :transferings do |t|
    	t.string  "argb"
    	t.string  "argn"

    	t.timestamps null: false
    end
  end
end
