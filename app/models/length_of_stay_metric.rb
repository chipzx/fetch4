class LengthOfStayMetric < ActiveRecord::Base
  include MultiTenant
  include DataSeries

  def self.by_age_groups
    by_age_groups = LengthOfStayMetric.where("outcome_type = 'Adoption'").group(:animal_type, :fiscal_year, :age_group).order(:age_group).average(:length_of_stay)
    return create_series(by_age_groups)
  end

  def self.by_length_of_stay
    by_length_of_stay = LengthOfStayMetric.where("outcome_type = 'Adoption'").group(:animal_type, :fiscal_year).order(:animal_type).average(:length_of_stay)
    return create_by_year_series(by_length_of_stay)
  end
end
