module Loader

  # Class to load PetPoint animal inventory data. Data comes from a CSV download of the Animal Inventory Report (summary).
  #--
  # CSV file has 2 records 
  #  - first record is on first two lines and gives date and report criteria
  #  - followed by blank line
  #  - followed by header record of actual data
  # So you want to skip first 3 lines in file
  #
  # Fields in file:
  # location1 - Equivalent to kennel
  # AVG_LOS - ignore
  # Distinct_Animals - ignore
  # AnimalNumber - animal_id
  # AnimalName - name
  # AnimalType - transform to animal type id
  # PrimaryBreed - breed
  # Age - ignore, always seems to be nil
  # Color - coloring
  # Declawed - ignore
  # Pre-Altered - combine with Sex to get gender
  # IntakeType - transform to intake type id
  # Sex - combine with Pre-Altered to get gender
  # Stage - ignore
  # Location - ignore
  # ARN - ignore
  # ChipNumber - microchip id
  # Species - Same as animal type 
  # Secondary Breed - combine with primary breed
  # Date of Birth -  dob
  # Color Pattern - combine with color
  # Emancipation Date - ignore
  # SpayedNeutered - gender, check against sex and pre-altered
  # IntakeDateTime - transform to intake date
  # LOSInDays - ignore
  # StageChangeReason - ignore
  # SubLocation - ignore
  # AnimalWeight - weight
  # Danger - ignore
  # DangerType - ignore
  # NumberOfPictures - ignore
  # Videos - ignore
  # HoldReason - ignore
  # HorForName - ignore
  # HoldStartDate - ignore
  # HoldPlacedBy - ignore
  # Total_Animals - ignore
  #++

  class PetpointCsvLoader < CsvLoader
 
    attr_accessor :animals

    def initialize(group, data_as_of)
      super(group)
      #TODO: Move this all to super class
      @group = group
      @data_as_of = data_as_of
      @animals = []
      @unknown_gender = 
        Gender.where("group_id = ? AND description = ?", @group.id, "Unknown").limit(1).to_a[0]
      Time.zone = group.time_zone
    end

    def read_file(file_path)
      options = Hash.new
      options[:headers] = true
      options[:return_headers] =  true
      tmp_file_path = remove_report_criteria_header(file_path)     
      @record_count = 0
      #begin
        read_records(tmp_file_path, options)      
      #rescue Exception
     
      #end
    end

    def read_records(path, options)
      @records = read_in_file(path, options) do |data|
        @record_count += 1
        # The last record may be a CsvRow with all nil values
        # Checking to see if data[0] is nil will handle that case
        if @record_count == 1 || data[0].nil?
puts "Continuing..."
          next
        end
        #begin
puts "Reading in animal"
          @animals << get_animal_from_record(data)
        #rescue Exception => ex
        #  puts ex.message
        #end
      end
    end

    def get_animal_from_record(record)
      animal = Animal.new
      animal.kennel_id = kennel(record["Location_1"])
      animal.group_id = @group.id
      animal.anumber = record["AnimalNumber"]
      animal.name = record["AnimalName"]
      animal.animal_type_id = animal_type_id(record["Species"])
      animal.breed = breed(record["PrimaryBreed"], record["SecondaryBreed"])
      animal.dob = dob(record["DateOfBirth"]) 
      animal.intake_type_id = intake_type_id(record["IntakeType"])
      animal.intake_date = intake_date(record["IntakeDateTime"])
      animal.coloring = coloring(record["Color"], record["ColorPattern"])
      animal.gender_id = gender(record["Sex"], record["PreAltered"], record["SpayedNeutered"])
      animal.microchip_number = record["ChipNumber"]
      animal.weight = weight(record["AnimalWeight"])
      return animal
    end

    def remove_report_criteria_header(file_path)
      tmp_file = Tempfile.new("inventory.csv")
      count = 0
      begin
        tmp = File.open(tmp_file.path, "w")
        File.open(file_path) do |file|
          file.each_line do |line|
            if (count > 2) 
              tmp.puts(line)
            end
            count += 1
          end
        end
      ensure
        tmp.close
      end
      return tmp_file.path
    end

    def kennel(name)
      return nil if name.nil?
      raise Exception, 'Group id is nil', caller if @group.nil? or @group.id.nil?
      begin
        name.squeeze!(" ")
        k = Kennel.where("name = ? and group_id = ?", name, @group.id)[0]
        if (k.nil?)
          k = Kennel.new_kennel(name, @group.id)
          k.save!
          puts("Added new kennel #{k.name}")
        end
        return k.id
      rescue Exception => ex
        err_msg = "Unable to process kennel #{name}: #{ex.message}"
        raise Exception, err_msg, caller
      end
    end

    def dob(dob_str)
      return nil if dob_str.nil?
      # expected format is "MM/DD/YYYY HH:MI:SS [A|P]M"
      begin
        dob = Time.strptime(dob_str, '%m/%d/%Y %H:%M:%S %p')      
        raise if dob.nil?
      rescue
        throw Exception, "Unable to convert #{dob_str} to a date for DOB", caller
      end
      return dob
    end

    def intake_date(intake_date_time)
      return parse_date(intake_date_time, '%m/%d/%Y %H:%M %p')
    end

    def parse_date(date_str, format)
      return nil if date_str.nil?
      begin
        the_date = Time.strptime(date_str, format)
        raise Exception "Attempt to convert #{date_str} using #{format} returned nil", caller if the_date.nil?
        return the_date
      rescue Exception => ex
        raise Exception, "Unable to convert #{date_str} using format #{format} to a date: #{ex.message}", caller
      end
    end

    def breed(primary, secondary)
      concat(primary, secondary)
    end

    def coloring(color, pattern)
      concat(color, pattern)
    end

    def animal_type_id(species)
      animal_type = AnimalType.where("name = ? AND group_id = ?", species, @group.id)[0]
      raise Exception, "Could not find animal type #{species}", caller if animal_type.nil?
      return animal_type.id
    end

    def concat(str1, str2)
      return nil if str1.nil? && str2.nil?
      str1 = '' if (str1.nil?)
      str2 = '' if (str2.nil?)
      return str1 + " " + str2 if (str2.length > 0)
      return str1
    end

    def gender(sex, spayed_neutered, pre_altered)
      indicator = case sex.upcase
        when 'F' then
          if (spayed_neutered.eql?('Y') || pre_altered.eql?('Y'))
            'S' 
          else
            'F'
          end
        when 'M' then
          if (spayed_neutered.eql?('Y') || pre_altered.eql?('Y'))
            'N' 
          else 
            'M'
          end
        else
          'U'
      end
puts("Gender indicator is #{indicator}")
      gender = Gender.where("name = ? AND group_id = ?", indicator, @group.id)[0]
      raise Exception, "Unable to compute gender from #{sex} #{spayed_neutered} #{pre_altered}" if gender.nil?
      return gender.id
    end

    def intake_type_id(intake_type_str)
      name = case intake_type_str.split("/")[0]
        when 'Stray' then 'Stray'
        when 'Owner' then 'Owner/Guardian Surrender'
        when 'Seized' then 'Seized / Custody'
        when 'Clinic' then 'Clinic'
        when 'Wildlife' then 'Wildlife In'
        when 'Return' then 'Return'
        when 'Transfer' then 'Transfer In'
        else 'Unknown'
      end
      intake_type = IntakeType.where("name = ? AND group_id = ?", name, @group.id)[0]
      raise Exception, "Unable to find intake type #{name}", caller if intake_type.nil?
      return intake_type.id
    end

    def weight(animal_weight)
      return nil if animal_weight.nil?
      elems = animal_weight.split(" ")
      begin
        return elems[0].to_f
      rescue
        raise Exception, 'Unable to convert weight value of #{animal_weight} to a number', caller
      end
    end

  end   # class PetpointCsvLoader

end # module Loader
