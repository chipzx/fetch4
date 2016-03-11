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
          label = "#{f[0]}: #{zero_month(f[1])}"
          totals = f[2]
          value << label
          value << totals
          values << value
        end
        dataset = Hash.new
        dataset["name"] = key
        dataset["data"] = values
        series << dataset
      end
      return series
    end
  
    def zero_month(period)
      return 'Unknown' if period.nil?
      return period if (period.class == String)
      return period < 10 ? "0" + period.to_s : period.to_s
    end
  end
end
