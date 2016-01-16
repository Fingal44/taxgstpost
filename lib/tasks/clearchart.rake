namespace :cleartest do
 require Rails.root.join('app', 'models', 'chart.rb')
  desc "Delete all records from charts table"
  task :clearall do

      @chart = Chart.all

      @chart.delete('code < 90000')
    end
  end

