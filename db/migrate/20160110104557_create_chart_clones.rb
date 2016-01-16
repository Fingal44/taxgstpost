class CreateChartClones < ActiveRecord::Migration
  def change
    create_table :chart_clones do |t|
      t.string :content

      t.timestamps null: false
    end
   end
end
