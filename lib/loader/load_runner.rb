module Loader
  class LoadRunner
  
    attr_accessor :data_load_record, :records, :start_time, :end_time

    def initialize(group_name, import_type, data_as_of)
      set_group_and_time_zone(group_name)
      @import_type = import_type
      @data_as_of = data_as_of
    end
  
    def set_start_time
      @start_time = DateTime.now
    end

    def set_end_time
      @end_time = DateTime.now
    end

    def load
      set_start_time
      success = false
      begin
        @data_load_record = get_data_load_record
        file_path = data_load_record.data_path
        @records = read_file_into_records(file_path, data_load_record.load_class)
puts("Read #{@records} records from #{file_path}")
        update_animals(@records)
        archive_file(file_path, data_load_record.archive_dir_path)
        success = true
      ensure
        log_data_load(success)
      end
      if (success)
        display_results
      end
    end
  
    def get_data_load_record()
      data_load_record = DataLoad.where("group_id = ? AND data_load_type_id = ?", @group.id, @import_type)
      if (data_load_record.nil?)
        raise Exception, "No data load record found for group #{@group.name} import type  #{@import_type}"
      end
      return data_load_record.first
    end

    def update_animals(records)
      new_recs = get_adds_and_updates(records)
      get_outcomes(new_recs)
      do_updates
    end

    def archive_file(file_path, archive_dir)
      basename = File.basename(file_path)
      fname, ext = basename.split(".")
      date_str = @data_as_of.strftime("%Y_%m_%d")
      archive_dir_path =  "#{Rails.root.to_s}/#{archive_dir}"
      Dir.mkdir(archive_dir_path) unless Dir.exist?(archive_dir_path)
      archive_file_path = "#{archive_dir_path}/#{fname}_#{date_str}.#{ext}"
      full_path = "#{Rails.root.to_s}/#{file_path}"
      File.rename(full_path, archive_file_path)
    end

    def get_adds_and_updates(records)
      @adds = []
      @updates = [] 
      new_recs = Hash.new
      records.each do |rec|
        # save each record, hashed by the anumber
        new_recs[rec.anumber] = rec
        db_rec = Animal.find_by_anumber(rec.anumber)
        if (db_rec.nil?)
          @adds << rec
        else
          if (changed(rec, db_rec))
            @updates << rec
          end
        end
      end
      return new_recs
    end

    def changed(rec, db_rec)
      unless (rec.nil? || db_rec.nil?)
        return true unless rec.name.eql?(db_rec.name)
        return true unless rec.intake_date.eql?(db_rec.intake_date)
        return true unless rec.breed.eql?(db_rec.breed)
        return true unless rec.coloring.eql?(db_rec.coloring)
        return true unless rec.weight.eql?(db_rec.weight)
        return true unless rec.dob.eql?(db_rec.dob)
        return true unless rec.description.eql?(db_rec.description)
      end
      return false
    end

    def get_outcomes(new_recs)
      @outcomes = []
      Animal.all.to_a.each do |a|
        unless new_recs.has_key?(a.anumber)
          @outcomes << a
        end
      end
    end

    def do_updates
      ActiveRecord::Base.transaction do
puts "Adding new animals"
        @adds.each do |rec|
puts "\tAdded #{rec.anumber} #{rec.name}"
          rec.save
        end
puts "Updating existing animals"
        @updates.each do |rec|
puts "\tUpdated #{rec.anumber} #{rec.name}"
          update_animal(rec)
        end
puts "Updating outcomes"
        @outcomes.each do |rec|
puts "\tMoving #{rec.anumber} #{rec.name} to outcomes"
          move_to_outcomes(rec)
        end
      end
      end_time = set_end_time
    end

    def update_animal(rec)
      animal = Animal.where("anumber = ?", rec.anumber).first
      animal.name = rec.name unless rec.name.eql?(animal.name)
      animal.intake_date = rec.intake_date unless rec.intake_date.eql?(animal.intake_date)
      animal.breed = rec.breed unless rec.breed.eql?(animal.breed)
      animal.coloring = rec.coloring unless rec.coloring.eql?(animal.coloring)
      animal.gender_id = rec.gender_id unless rec.gender_id.eql?(animal.gender_id)
      animal.dob = rec.dob unless rec.dob.eql?(animal.dob)
      animal.weight = rec.weight unless rec.weight.eql?(animal.weight)
      animal.description = rec.description unless rec.description.eql?(animal.description)
      animal.save
    end

    def move_to_outcomes(animal)
      outcome = Outcome.to_outcome(animal, @data_as_of)
puts("Moving #{outcome} to outcomes")
      outcome.save!
    end

    def log_data_load(success)
      set_end_time
      log = DataLoadLog.new
      log.data_load_id = @data_load_record.nil? ? 1 : @data_load_record.id 
      log.start_time = @start_time
      log.end_time = @end_time
      log.date_loaded = Time.now
      log.data_as_of =  @data_as_of
      log.was_successful = success
      if (success)
        log.total_rows = @records.size
        log.total_added = @adds.size
        log.total_updated = @updates.size
        log.total_outcomes = @outcomes.size
        log.total_errors = 0
      end
      log.save
    end

    def set_group_and_time_zone(group_name)
      group = Group.where("name = ?", group_name)
      raise Exception, "There is no group named #{group_name}" if group.nil?
      @group = group.first # group_name is unique, so there's only one
      @tz = ActiveSupport::TimeZone.new(@group.time_zone)
      Time.zone = @tz
    end

    def read_file_into_records(file_path, loader_class)
      # instantiate the load class - loaders should always be in Loader:: namespace
      clazz = loader_class.split("::").inject(Object) { |o, c| o.const_get c }
      @loader = clazz.new(@group, @data_as_of)
      @loader.read_file(file_path)
      return @loader.animals
    end
  
    def display_results
      puts("Processed #{@records.size} animal records")
      puts("Added #{@adds.size} animals")
      puts("Updated #{@updates.size} animals")
      puts("Moved #{@outcomes.size} animals to outcomes")
    end

  end  #LoadRunner
end  # Loader namespace
