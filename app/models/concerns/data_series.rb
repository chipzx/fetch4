module DataSeries
 extend ActiveSupport::Concern

  module ClassMethods

  @@months = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]

    def create_hc_series(result_set, period = :year, separator = " ")
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
            value << format_label(label, period)
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

    def format_label(label, period)
      return label if period == :year
      return as_quarter(label) if period == :quarter
      return as_month(label) if period == :month
      return as_week(label) if period == :week
      return as_day(label) if period == :day_of_year
      return as_hour(label) if period == :hour
      return label
    end
   
    def as_hour(label)
      hh24 = label.to_i
      if (hh24 < 13)
        "#{hh24} AM"
      else
        "#{hh24-12} PM"
      end
    end

    def as_period(label)
      begin
        elems = label.split(" ")
        if (elems.length == 2)
          year = elems[0].to_i
          period = elems[1].to_i
          return yield(period, year)
        end
      #rescue
      #  puts("Unable to parse #{label} as a year-period string")
      end
      return label
    end

    def validate_period(period, min, max)
      if (period < min || period > max)
        raise Exception, "period value is #{period}, must be between #{min} and #{max}", caller
      end
    end

    def as_quarter(label)
      as_period(label) do |period, year| 
        validate_period(period, 1, 4)
        "#{year} Q#{period}" 
      end

    end

    def as_month(label)
      as_period(label) do |period, year| 
        validate_period(period, 1, 12)
        "#{year} #{@@months[period-1]}"
      end
    end

    def as_week(label)
      as_period(label) do |period, year|
        validate_period(period, 1, 53)
        date_str = ""
        if (period == 53) # don't know why Date.commercial doesn't handle this
          date_str = "Dec 31" 
        else
          date_str = Date.commercial(year, period, 7).strftime("%b %e")
        end
        #{year} #{date_str}"
      end
    end

    def as_day(label)
      as_period(label) do |period, year|
        validate_period(period, 1, 366)
        Date.strptime("#{year}-#{period}", "%Y-%j").to_s
      end
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
