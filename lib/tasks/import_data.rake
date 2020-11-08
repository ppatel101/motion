desc "Import Data"

task :import do
  puts "Importing data..."
  @client = Airtable::Client.new("keyhXrpBAbFcsnvCg")
  @table = @client.table("appLcC0RMOQHOHeMA", "t1")
  @records = @table.records
  array = []
  @table.records.each do |item|
    array << item.fields.except(:id)
  end
  file = File.open("public/temp.json","w")
  file.write(JSON.pretty_generate(array))
  file.close
  puts "Importing data Sucessfully..."
end