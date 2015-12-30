namespace :admin do
  desc "Provision a new group"
  task :provision_group, [:arg1, :arg2, :arg3] => :environment do |t, args|
    puts "Creating new group..."
    name = args[:arg1]
    tz = args[:arg2]
    descr = args[:arg3]
    puts "Group name is #{name}"
    puts "Description is #{descr}"
    puts "Time zone is #{tz}"
    ActiveRecord::Base.transaction do
      newGroup = Group.new(:name => name, :time_zone => tz, :description => descr)
      newGroup.save!
      root_id = Group.find_by_name('root').id
      group_id = newGroup.id
      puts "Provisioning animal_types for group_id #{group_id}"
      AnimalType.provision(root_id, group_id)
      puts "Provisioning intake_types for group_id #{group_id}"
      IntakeType.provision(root_id, group_id)
      puts "Provisioning outcome_types for group_id #{group_id}"
      OutcomeType.provision(root_id, group_id)
      puts "Provisioning gender types for group_id #{group_id}"
      Gender.provision(root_id, group_id)
      puts "Provisioning kennel types for group_id #{group_id}"
      KennelType.provision(root_id, group_id)
      puts "Provisioning roles for group_id #{group_id}"
      Role.provision(root_id, group_id)
    end
  end

  task :create_data_load, [:arg1, :arg2, :arg3] => :environment do |t, args|
    puts 'Creating new data load entry...'
    loader = DataLoad.new
    loader.create_data_load(args[:arg1], args[:arg2], args[:arg3])
  end
end
