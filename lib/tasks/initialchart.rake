namespace :demotest do
  require 'csv'
  desc "Imports a CSV file into an ActiveRecord table"
  
  task :import, [:filename] => :environment do |t,args|
    args.with_default("trt1.csv")
    #file1 = File.open(args.filename)
    
    CSV.foreach(args.filename) do
    |row|
      rr = row.inspect
      ssk = rr.split('\t')
      
      @chart = Chart.new
      # byebug
      @chart.code=  ssk[0].from(2)
      @chart.content=  ssk[1]

      if ssk[2]== 1
        @chart.header=  1
      else
        @chart.header=  0
      end

#byebug
      if ssk[3]== 1
        @chart.gst=  1
      else
        @chart.gst=  0
      end

      #@chart.glcode=  ssk[4].to(-3)
      @chart.save
    end
   
  end
  
 end

namespace :demotestold do
  require 'csv'
  desc "Imports a CSV file into an ActiveRecord table"
  task :importold, [:filename] => :environment do

    CSV.foreach('trt2.csv') do
    |row|
      rr = row.inspect
      ssk = rr.split('\t')
      @chart = Chart.new
      @chart.code=  ssk[0].from(2)
      @chart.content=  ssk[1]

      if ssk[2]=='H'
        @chart.header=  1
      else
        @chart.header=  0
      end


      if (ssk[3]=='S') or  (ssk[3]=='S15')
        @chart.gst=  1
      else
        @chart.gst=  0
      end

      @chart.glcode=  ssk[4].to(-3)
      @chart.save
    end
  end
end
 
namespace :tale do
  desc "Expects to get a file or folder ..."
  task :import_kml, [:filename] do |t, args|
    args.with_default(:filename => :environment)
    puts "args = #{args.inspect}"
  end
end


namespace :tale1 do
  desc "Imports a CSV file into an ActiveRecord table"
  task :csv_model_import, [:filename, :model, :needs] => :environment do |t,args|
    lines = File.new(args[:filename]).readlines
  
    header = lines.shift.strip
    keys = header.split(',')
    lines.each do |line|
      values = line.strip.split(',')
    
      attributes = Hash[keys.zip values]
   # byebug
      Module.const_get(args[:model]).create(attributes)
   # byebug
    end
  end
  
  desc "Create user copy of chart"
  task :user_chart, [:userid] => :environment do |t,args|
    @charts = Chart.where("users_id = ?",0)
    @charts.each do |row|
      #byebug
      @cht = Chart.new
      @cht.code = row.code
      @cht.glcode = row.glcode
      @cht.content = row.content
      @cht.header = row.header
      @cht.gst = row.gst
      @cht.users_id = args[:userid]
      # byebug
      @cht.save
    end
  end  
end
