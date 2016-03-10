class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @yearly_total_chart = build_yearly_total_chart();
  end

  private
    def build_yearly_total_chart()
      today = Date.today
      current_date = Date.new(2010, 1, 1)

      yearly_total = Array.new
      while current_date <= today
        yearly_total << Transaction.where(:date => current_date.beginning_of_year .. current_date.end_of_year).sum(:value).to_f;
        current_date = current_date.next_year
      end

      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Gasto total por ano")
        f.xAxis(categories: (2010..2016).to_a)
        f.yAxis(min: 0, title: nil)
        f.series(name: "Gasto total", data: yearly_total)

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({type: "column", height: 300})
      end
    end
end