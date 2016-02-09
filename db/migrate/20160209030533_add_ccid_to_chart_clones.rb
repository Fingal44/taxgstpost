class AddCcidToChartClones < ActiveRecord::Migration
  def change
  	add_column :chart_clones, :cc_id, :integer
  end
end
