namespace :import do
  desc "Geocode intake and address data"
  task :geocode_intakes, [:arg1] => :environment do |t, args|
    group_name = args[:arg1]
    if (group_name.nil?)
      puts "Must supply a group name - quitting"
    else
      group = Group.by_name(group_name)
      unless group.nil?
        intakes = Intake.where("(latitude IS NULL OR valid_address IS NULL) AND group_id = ?", group.id).limit(2500)
        intakes.to_a.each do |i|
          i.geocode
          i.save!
          puts("Geocoded #{i.found_location} to #{i.latitude} #{i.longitude}")
          sleep(5)
        end
      else 
        puts("No group found for #{group_name}")
      end
    end
  end
end
