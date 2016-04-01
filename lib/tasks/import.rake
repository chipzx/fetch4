load 'lib/loader/csv_loader.rb'
load 'lib/loader/load_runner.rb'
load 'lib/loader/petpoint_csv_loader.rb'
namespace :import do
  desc "Import animal inventory data"
  task :import_animals, [:arg1] => :environment do |t, args|
    group_name = args[:arg1]
    pp = PetpointCsvLoader(group_name, DateTime.now)
    if (group_name.nil?) 
      puts "Must supply a group name - quitting"
    else
      puts "Importing animal data for #{group_name}"
      loader = Loader::LoadRunner.new(group_name, 1, Date.today)
      loader.load
    end
  end
end
