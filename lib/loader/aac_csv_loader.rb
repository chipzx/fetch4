module Loader

  class AacCsvLoader < CsvLoader
    
    # the aac_data.csv has three hex characters at the beginning of the file - \xEF, \xBB, \xBF
    # need to encode them into the string used as the key
    KENNEL_KEY = "\xEF\xBB\xBFKennel".force_encoding("utf-8")
  
    attr_reader :animals

    def initialize(group, data_as_of)
      super(group)
      @group = group
      @data_as_of = data_as_of
      @animals = []
      expected_columns = 
        [ KENNEL_KEY, "Animal_ID", "Animal_Name1", "Intake_Date", "Breed", "Color",
          "Sex", "Age", "Weight", "Intake_Behavior_Memo" ]
  
      @unknown_gender = 
        Gender.where("group_id = ? AND description = ?", @group.id, "Unknown").limit(1).to_a[0]
    end
  
    def read_file(file_path)
      options = Hash.new
      options[:headers] = true
      options[:return_headers] = true
      first = true
      records = read_in_file(file_path, options) do |data|
         unless first
           # handle blank record at end
           break if data.size == 0
           animal = Animal.new()
           animal.kennel_id = convert_kennel(data[KENNEL_KEY])
           animal.anumber = data["Animal_ID"]
           animal.group_id = @group.id
           animal.name = data["Animal_Name1"]
           animal.intake_date = data["Intake_Date"]
           animal.breed = data["Breed"]
           animal.coloring = data["Color"]
           animal.gender_id = convert_gender(data["Sex"])
           animal.dob = convert_age(data["Age"], @data_as_of)
           animal.weight = convert_weight(data["Weight"])
           animal.description = data["Intake_Behavior_Memo"]
           @animals << animal
         else 
           first = false
         end
      end
      puts "Read #{animals.size} animal records from #{file_path}"
    end
  
    def convert_kennel(name)
puts "Kennel name is #{name}"
      unless name.nil?
        k = Kennel.find_by_name(name)
        if (k.nil?)
          k = Kennel.new_kennel(name)
        end
        return k.id
      else 
        return nil
      end
    end
  
    def convert_intake_date(aDateStr)
      return convert_date(aDateStr, "%m/%d/%Y")
    end
  
    def convert_gender(sex)
      g = Gender.find_by_description(sex)
      return g.nil? ? @unknown_gender.id : g.id
    end
   
    def convert_age(age, theDate)
      dob = age_to_date(age, theDate) 
    end
  
    def convert_weight(weight)
      return nil if weight.nil?
      return weight.delete("lbs").strip
    end
  
    def age_to_date(age, theDate)
      return nil if age.nil?
      elems = age.split(",")
      elems.each do |elem|
        vals = elem.split(" ")
        time = vals[0].to_i
        period = vals[1]
        if (period.downcase[0].eql?("m"))
          theDate = theDate.months_ago(time)
        elsif (period.downcase[0].eql?("y"))
          theDate = theDate.years_ago(time)
        elsif (period.downcase[0].eql?("d"))
          theDate = theDate - time
        end
      end
      return theDate
    end
  
  end
  
end
