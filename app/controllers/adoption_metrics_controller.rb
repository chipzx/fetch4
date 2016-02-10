class AdoptionMetricsController < ApplicationController
  def index
    by_day_chart
    set_globals
  end

  private
  def set_globals
    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        backgroundColor: {
          linearGradient: [ 0, 0, 500, 500 ],
          stops: [
            [0, "rgb(255, 255, 255)"]
          ]
        },
        borderWidth: 2, 
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: true,
        plotBorderWidth: 1
      )
      f.lang(thousandSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
    end
  end

  def by_day_chart
    @by_day_id = "adoptions_by_day"
    @by_day_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title("Adoptions By Day")
      f.xAxis(categories: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
      f.series(name: "Total Adoptions", yAxis: 0, data: [112, 205, 228, 204, 235, 387, 261])

      f.yAxis [
        { title: { text: "Total Adoptions", margin: 70} }
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end
  end
end
