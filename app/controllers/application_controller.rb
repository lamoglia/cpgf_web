class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @yearly_total_chart = build_yearly_total_chart();
    @total_by_superior_organ_chart = build_total_by_superior_organ_chart();
    @total_by_person_chart = build_total_by_person_chart();
    @total_by_favored_chart = build_total_by_favored_chart();
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

    def build_total_by_superior_organ_chart()
      superior_organs = SuperiorOrgan.all

      superior_organs_total = Array.new
      superior_organs.each do |organ|
        superior_organs_total << Transaction.where(:superior_organ => organ).sum(:value).to_f;
      end

      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Gasto total por Órgão Superior")
        f.xAxis(categories: superior_organs.collect {|t| t.name})
        f.yAxis(min: 0, title: nil)
        f.series(name: "Gasto total", data: superior_organs_total)

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({type: "bar", height: 800})
      end
    end

    def build_total_by_person_chart()
      people_names = Array.new
      people_totals = Array.new
      Transaction.select("person_id, sum(value) as total").group("person_id").order("total DESC").limit(11).each do | rec |
        person = Person.find(rec.person_id)
        if !person.name.nil?
          people_names << person.name
          people_totals << rec.total.to_f
        end
      end

      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Gasto total por Portador")
        f.xAxis(categories: people_names)
        f.yAxis(min: 0, title: nil)
        f.series(name: "Gasto total", data: people_totals)

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({type: "bar"})
      end
    end

    def build_total_by_favored_chart()
      favored_names = Array.new
      favored_totals = Array.new
      Transaction.select("favored_id, sum(value) as total").group("favored_id").order("total DESC").limit(11).each do | rec |
        favored = Favored.find(rec.favored_id)
        if !favored.name.nil?
          favored_names << favored.name
          favored_totals << rec.total.to_f
        end
      end

      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Gasto total por Favorecido")
        f.xAxis(categories: favored_names)
        f.yAxis(min: 0, title: nil)
        f.series(name: "Gasto total", data: favored_totals)

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({type: "bar"})
      end
    end
end