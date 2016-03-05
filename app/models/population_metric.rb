class PopulationMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  def self.io_by_day

  end

  def self.io_by_month
    intakes = hash_by_animal_type(IntakeMetric.intakes_by_month)
    outcomes = hash_by_animal_type(OutcomeMetric.outcomes_by_month)
    return merge_period_totals(intakes, outcomes)
  end

  def self.io_by_week
    intakes = hash_by_animal_type(IntakeMetric.intakes_by_week)
    outcomes = hash_by_animal_type(OutcomeMetric.outcomes_by_week)
    return merge_period_totals(intakes, outcomes)
  end

  private
  def readonly?
    true
  end

  def self.hash_by_animal_type(series)
    by_key = Hash.new
    series.each do |r|
      key = r["name"]
      values = r["data"]
      dateHash = Hash.new
      values.each do |val|
        theDate = val[0]
        intakes = val[1]
        dateHash[theDate] = intakes
      end
      by_key[key] = dateHash
    end
    return by_key
  end

  def self.merge_period_totals(intakes, outcomes)
    series = []
    intakes.each_key do |key|
      data = []
      idata = intakes[key]
      odata = outcomes[key]
      idata.each_key do |period|
        next if odata[period].nil?
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
