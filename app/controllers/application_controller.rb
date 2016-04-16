class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @yearly_total_chart = build_yearly_total_chart();

    @summary_by_favored = build_summary_by_favored();
    @summary_by_person = build_summary_by_person();
    @total_by_superior_organ_chart = build_total_by_superior_organ_chart();
  end

  private

    def build_summary_by_favored()
      Favored.with_total_transactions.limit(10)
    end

    def build_summary_by_person()
      Person.with_total_transactions.limit(10)
    end

    def build_yearly_total_chart()
      today = Date.today
      current_date = Date.new(2010, 1, 1)

      yearly_total = Array.new
      while current_date <= today
        yearly_total << Transaction.where(:date => current_date.beginning_of_year .. current_date.end_of_year).sum(:value).to_f;
        current_date = current_date.next_year
      end

      LazyHighCharts::HighChart.new('graph') do |f|
        f.xAxis(categories: (2010..2016).to_a)
        f.yAxis(min: 0, title: nil)
        f.series(name: "Gasto total", data: yearly_total)

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({type: "column", height: 300})
      end
    end

    def build_total_by_superior_organ_chart()
      superior_organs_total = Array.new
      sum = 0

      total = Transaction.sum('value');
      Transaction.select("superior_organ_id, sum(value) as total").group("superior_organ_id").order("total DESC").limit(10).each do | rec |
        superior_organ = SuperiorOrgan.find(rec.superior_organ_id)
        superior_organs_total << [superior_organ.name, rec.total.to_f];
        sum += rec.total.to_f

        if (sum > total/1.2) then
          superior_organs_total << ['OUTROS', (total - sum).to_f];
          break
        end
      end

      LazyHighCharts::HighChart.new('pie') do |f|
        f.title(text: "Gasto por Órgão Superior")
        f.series(name: "Gasto por Órgãos Superior", data: superior_organs_total)

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({type: "pie"})
      end
    end
end