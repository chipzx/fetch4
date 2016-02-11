require 'lazy_high_charts/high_chart_globals'

module AdoptionMetricsHelper
  def high_chart_globals(opts)
    opts.merge_options("high_chart_globals", opts)
  end
end
