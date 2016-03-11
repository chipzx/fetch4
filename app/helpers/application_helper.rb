module ApplicationHelper
  def pp_filter(filter)
    return filter.nil? ? "All" : filter.to_s.capitalize
  end
end
