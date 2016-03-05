module DataSeries
 extend ActiveSupport::Concern

  module ClassMethods

    def create_by_year_series(result_set)
      # result_set has form [[type, year], count] 
      series = []
      groups = result_set.to_a.group_by { |stat| stat[0][0] }
      groups.each do |key, val|
        values = []
        val.each do |v|
          value = []
          f = v.flatten.slice(1,2)
          value << f[0]
          value << f[1]
          values << value
        end
        dataset = Hash.new
        dataset["name"] = key
        dataset["data"] = values
        series << dataset
      end 
      return series
    end

    def create_series(result_set)
      series = []
      groups = result_set.to_a.group_by { |stat| stat[0][0] }
      groups.each do |key, val|
        values = []
        val.each do |v|
          value = []
          # v has form "[[type, year, period], count]"
          f = v.flatten.slice(1,3) # get rid of type, it's the same value as key

          dayMnth = "#{f[0]}/#{zero_month(f[1])}"
          totalIntakes = f[2]
          value << dayMnth
          value << totalIntakes
          values << value
        end
        dataset = Hash.new
        dataset["name"] = key
        dataset["data"] = values
        series << dataset
      end
      return series
    end
  
    def zero_month(month)
      return month < 10 ? "0" + month.to_s : month.to_s
    end
  end
end
