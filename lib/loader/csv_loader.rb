require 'csv'
module Loader

  class CsvLoader
  
    attr_accessor :added, :updated, :deleted, :group, :tz, :effective_date
  
    def initialize(group)
      @added   = 0
      @updated = 0
      @deleted = 0
  
      @group = group
      @tz = ActiveSupport::TimeZone.new(@group.time_zone)
      Time.zone = @tz
    end
  
    def read_in_file(file_path, options)
      records = []
      if (File.exist?(file_path))
        get_effective_date(file_path)
        CSV.foreach(file_path, options) do |data|
          yield data
          records << data
        end
      else
        raise Exception, "File #{file_path} does not exist"
      end    
      return records
    end
  
    def convert_date(aDateStr, format)
      DateTime.strptime(aDateStr, format).in_time_zone
    end
  
    def get_effective_date(file_path)
      # if date embedded in file path name, use that
      @effective_date = get_date_from_path(file_path.split("/").last)
      # else use the mtime of the file
      if @effective_date.nil?
        @effective_date = File.new(file_path).mtime
      end
    end
  
    def get_date_from_path(path)
      begin
        fname = path.split("/").last
        elems = fname.split(/[[.][_][-]]/)
        if elems.size >= 6
          last = elems.size-1
          day = elems[last-1].to_i
          month = elems[last-2].to_i
          year = elems[last-3].to_i
          if (day >= 1 and day <= 31) &&
             (month >= 1 and month <= 12) &&
             (year > 1900 and year < 2100)
            @date_from_path = true
            return Time.new(year, month, day)
          else
            return nil
          end
        end
      rescue
        return nil
      end
      return nil
    end

  end
  
end
