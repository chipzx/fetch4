namespace :admin do
  desc "Provision a new group"
  task :provision_group, [:arg1, :arg2, :arg3] => :environment do |t, args|
    puts "Creating new group..."
    name = args[:arg1]
    tz = args[:arg2]
    descr = args[:arg3]
    if (descr.nil? || tz.nil? || name.nil?)
      puts("Usage:  rake admin:provision_group[name,time_zone,description]")
    else
      puts "Group name is #{name}"
      puts "Description is #{descr}"
      puts "Time zone is #{tz}"
      ActiveRecord::Base.transaction do
        newGroup = Group.new(:name => name, :time_zone => tz, :description => descr)
        newGroup.save!
        root_id = Group.find_by_name('root').id
        group_id = newGroup.id
        provisionable_classes = ProvisionedCodeTable.provisionables
        raise 'No provisionables found' if provisionable_classes.empty?
        provisionable_classes.each do |klass|
          puts "Provisioning #{klass.name} for group_id #{group_id}"
          klass.send "provision", root_id, group_id
        end
      end
    end
  end

  task :create_data_load, [:arg1, :arg2, :arg3] => :environment do |t, args|
    puts 'Creating new data load entry...'
    loader = DataLoad.new
    loader.create_data_load(args[:arg1], args[:arg2], args[:arg3])
  end
end
