namespace :demotest_1 do
  desc "TODO"
  task import_1: :environment do 
  	  # args.with_default("charts13.csv")
  	  filen = File.open("charts13.csv")
    #file1 = File.open(args.filename)
   
       CSV.foreach(filen) do |row|
          rr = row.inspect
          ssk = rr.split(',')
         # byebug
          @chart = Chart.new
          @chart.code = ssk[2].from(2).to(-2)
          @chart.content = ssk[3].from(2).to(-2)
          @chart.gst = ssk[1].from(2).to(-2)
          @chart.header = ssk[4].from(2).to(-2)
          @chart.users_id = ssk[5].from(2).to(-2)
          @chart.created_at = ssk[8].from(2).to(-2)
          @chart.updated_at = ssk[9].from(2).to(-2)
          @chart.glcode = @chart.code.to_i/10000
          if @chart.users_id == 0
            @chart.save
          end
        end
  end

end
