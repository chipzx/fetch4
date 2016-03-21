module DataSeries
 extend ActiveSupport::Concern

  module ClassMethods

    def create_hc_series(result_set, separator = " ")
      series = []
      results = result_set.to_a

      if results.size > 0 && results[0][0].kind_of?(Array)  
        groups = results.group_by { |r| r[0][0] } 
        groups.each do |key, val|
          values = []
          val.each do |v|
            value = []
            vf = v.flatten
            f = vf.slice(1,vf.length-1)
            label = f[0..f.length-2].join(separator)
            totals = f[-1]
            value << label
            value << totals
            values << value
          end
          dataset = Hash.new
          dataset["name"] = key
          dataset["data"] = values
          series << dataset
        end          
      else
        series = results
      end    
      return series
    end

    def zero_month(period)
      return 'Unknown' if period.nil?
      return period if (period.class == String)
      return period < 10 ? "0" + period.to_s : period.to_s
    end

    def hash_entries(series)
      by_key = Hash.new
      series.each do |entry|
        key = entry["name"]
        by_key[key] = entry["data"].to_h
      end
      return by_key
    end
  
    def merge_totals_by_key(intakes, outcomes)
      series = []
      intakes.each_key do |key|
        data = []
        idata = intakes[key]
        odata = outcomes[key]
        idata.each_key do |period|
          next if odata.nil? || odata[period].nil?
          itotal = idata[period]
          ototal = odata[period]
          unless itotal.nil? || ototal.nil?
            counts_for_period = [ period, ototal-itotal ] unless itotal.nil? || ototal.nil?
            data << counts_for_period
          end
        end
        dataset = Hash.new
        dataset["name"] = key
        dataset["data"] = data
        series << dataset
      end
      return series
    end

  end
end
